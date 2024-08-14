#!/usr/bin/env python3
""" Writing strings to Redis """
import functools
import redis
import uuid
from typing import Union, Callable, Optional


def count_calls(method: Callable) -> Callable:
    """
       Decorator that counts method calling times
    """
    @functools.wraps(method)
    def wrapper(self, *args, **kwargs):
        """
           Generates key using method's qualified name
           Increments the call count in Redis
           Call the original method and return its result
        """
        key = method.__qualname__
        self._redis.incr(key)
        return method(self, *args, **kwargs)

    return wrapper


class Cache:
    def __init__(self):
        """
            Init Redis client and flush db
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
            Generates a random key using uuid
            Stores the data in Redis using the generated key and returned it
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn:
            Optional[Callable] = None) -> Union[str, bytes, int, float, None]:
        """
            Retrieves datas from Redis using key
            Optionally, uses the callable fn for data conversion
            back to desired format
        """
        data = self._redis.get(key)
        if fn:
            return fn(data)

        return data

    def get_str(self, key: str) -> Optional[str]:
        """
           Retrieves data from Redis and convert it into a str
        """
        return self.get(key, lambda d: d.decode('utf-8'))

    def get_int(self, key: str) -> Optional[int]:
        """
           Retrieves data from Redis and convert it into an int
        """
        return self.get(key, int)
