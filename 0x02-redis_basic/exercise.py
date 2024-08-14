#!/usr/bin/env python3
""" Writing strings to Redis """
import redis
import uuid
from typing import Union


class Cache:
    def __init__(self):
        """
            Init Redis client and flush db
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
            Generates a random key using uuid
            Stores the data in Redis using the generated key and returned it
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key
