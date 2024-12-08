#
# Copyright (c) 2024 Samuel J. McKelvie
#
# MIT License - See LICENSE file accompanying this package.
#

"""
Common type definitions meant to be imported with "import *".
"""

from __future__ import annotations

from typing import (
    Dict, List, Optional, Union, Any, TypeVar, Tuple, overload,
    Callable, Iterable, Iterator, Generator, cast, TYPE_CHECKING,
    Mapping, MutableMapping, ParamSpec, Concatenate, Sequence, MutableSequence, Set, AbstractSet, MutableSet,
    KeysView, ValuesView, ItemsView, Literal, IO, Generic, Type, Self,
    NamedTuple,
  )

if TYPE_CHECKING:
    from _typeshed import SupportsKeysAndGetItem

# mypy really struggles with this
if TYPE_CHECKING:
  from subprocess import _CMD, _FILE, _ENV
  from _typeshed import StrOrBytesPath
else:
  _CMD = Any
  _FILE = Any
  _ENV = Any
  StrOrBytesPath = Any


from enum import Enum
from types import TracebackType, NoneType

JsonableTypes = ( str, int, float, bool, dict, list )
# A tuple of types to use for isinstance checking of JSON-serializable types. Excludes None. Useful for isinstance.

if TYPE_CHECKING:
  Jsonable = Union[str, int, float, bool, None, Dict[str, Any], List[Any]]
  """A Type hint for a simple JSON-serializable value; i.e., str, int, float, bool, None, Dict[str, Jsonable], List[Jsonable]"""
else:
  Jsonable = Union[str, int, float, bool, None, Dict[str, 'Jsonable'], List['Jsonable']]
  """A Type hint for a simple JSON-serializable value; i.e., str, int, float, bool, None, Dict[str, Jsonable], List[Jsonable]"""

JsonableDict = Dict[str, Jsonable]
"""A type hint for a simple JSON-serializable dict; i.e., Dict[str, Jsonable]"""

JsonableList = List[Jsonable]
"""A type hint for a simple JSON-serializable list; i.e., List[Jsonable]"""

class FactoryTownError(Exception):
    """
    Base class for exceptions in this module
    """
    pass

class UnsetType:
    def __str__(self):
        return "UNSET"

    def __repr__(self):
        return str(self)

UNSET = UnsetType()

