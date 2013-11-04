# Examines this system's OSX version and returns the URL to the latest available
# download of XCode's Command Line Tools.

import re
import json
import subprocess

def extract_version_tuple(version_str):
    return [int(str) for str in version_str.split('.')]

def valid_osx_version(download_info, current_version):
    predicates = download_info['userInfo']['ActivationPredicate'].split('&&')
    mac_version_constraints = filter(lambda x: re.search('MAC_OS_X_VERSION', x) != None,
                                     predicates)

    ops = {
        '>=' : lambda x, y: x >= y,
        '>'  : lambda x, y: x >  y,
        '<=' : lambda x, y: x <= y,
        '<'  : lambda x, y: x <  y,
    }

    for constraint in mac_version_constraints:
        # Extract operator and version from constraint
        m = re.search(r"(>=|>|<|<=)\s*'([^']+)'", constraint)

        if m == None:
            continue

        op, ver_str = m.groups()
        version_req = extract_version_tuple(ver_str)
        meets_requirement = ops[op](current_version, version_req)

        if not meets_requirement:
            return False

    return True

def current_osx_version():
    version_string = subprocess.check_output(['sw_vers', '-productVersion'])
    return extract_version_tuple(version_string)

def main():
    # Nasty, but makes it convenient for us to run this as a simple python
    # script, rather than having to execute these commands via shell and pipe
    # the results in to this app
    curl = subprocess.Popen([
        'curl', '-Ls',
        'https://devimages.apple.com.edgekey.net/' +
        'downloads/xcode/simulators/' +
        'index-3905972D-B609-49CE-8D06-51ADC78E07BC.dvtdownloadableindex'
    ], stdout=subprocess.PIPE)

    plutil = subprocess.Popen(['plutil', '-convert', 'json', '-o', '-', '-'],
                              stdin=curl.stdout, stdout=subprocess.PIPE)

    conversion = subprocess.Popen(['python', '-mjson.tool'],
                                  stdin=plutil.stdout, stdout=subprocess.PIPE)

    json_doc = json.load(conversion.stdout)

    xcode_clt_packages = [download for download in json_doc['downloadables']
                                   if download['name'] == "Command Line Tools"]

    # Find packages that meet OSX version requirements
    current_version = current_osx_version()
    downloadable_packages = filter(
        lambda x: valid_osx_version(x, current_version),
        xcode_clt_packages,
    )

    if len(downloadable_packages) == 0:
        print 'No download available'
        exit(1)

    latest = max(
        downloadable_packages,
        key=lambda x: extract_version_tuple(x['version']),
    )

    print latest['source']

main()
