import json
import argparse
import logging

logging.basicConfig(level=logging.INFO)


def write_json_data(metadata_file_name, key, value):
    """
    Write data to provided json file

    Args:
        metadata_file_name: File Name where data has to write
        key: Key Name
        value: Value

    """
    dictionary = {
        "file_name": key,
        "md5sum": value
    }
    json_object = json.dumps(dictionary, indent=4)
    logging.info(f"Writting metadata for {key} and md5sum is {value}")
    with open(f"/mnt/test/{metadata_file_name}", "a+") as outfile:
        outfile.write(json_object)


if __name__ == "__main__":
    """
    Write Data to Json file
    Example usage::
         $ python write_metadata.py --metadata_file_name <file_name> --key <key> --value <value>
    """
    ap = argparse.ArgumentParser(description="Data Writer")
    ap.add_argument(
        "-mfn",
        "--metadata_file_name",
        dest="mfn",
        metavar="LABEL",
        required=True,
        help="Metadata file Name")
    ap.add_argument(
        "-k",
        "--key",
        dest="keys",
        metavar="LABEL",
        required=True,
        help="Key Name")
    ap.add_argument(
        "-v",
        "--value",
        dest="values",
        metavar="LABEL",
        required=True,
        help="Value")
    args = ap.parse_args()

    write_json_data(args.mfn, args.keys, args.values)
