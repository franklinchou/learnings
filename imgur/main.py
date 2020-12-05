import os
import json
import subprocess


if __name__ == '__main__':

    working_dir = './test'
    dump_file_name = 'dump.txt'

    dump_file_location = os.path.join(working_dir, dump_file_name)

    for _, jo in enumerate(json.loads(open(dump_file_location).read())):
        asset_url = jo['src']['image']
        bash_cmd = f"wget {asset_url} -P {working_dir}"
        proccess = subprocess.Popen(bash_cmd.split(), stdout=subprocess.PIPE)

