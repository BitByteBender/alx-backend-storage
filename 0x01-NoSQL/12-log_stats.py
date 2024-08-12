#!/usr/bin/env python3
""" Log stats """

from pymongo import MongoClient


def stats_logger():
    """
        Displays stats about Nginx logs
    """
    client = MongoClient("mongodb://127.0.0.1:27017")
    collection = client.logs.nginx

    overall_logs = collection.count_documents({})

    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    mth_counter = {mth: collection.count_documents({"method": mth})
                   for mth in methods}

    stat_checker = collection.count_documents({"method": "GET",
                                             "path": "/status"})

    print("{} logs".format(overall_logs))
    print("Methods:")
    for mth in methods:
        print("\tmethod {}: {}".format(mth, mth_counter[mth]))
    print("{} status check".format(stat_checker))


if __name__ == "__main__":
    stats_logger()
