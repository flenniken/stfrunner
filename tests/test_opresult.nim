import std/unittest
import opresult

suite "opresult.nim":

  test "OpResultWarn default":
    # The default message is "".
    var opResult: OpResult[int, string]
    check opResult.isValue == false
    check opResult.isMessage == true
    check opResult.message == ""
    check $opResult == "Message: \"\""

  test "OpResultWarn value":
    var opResult = OpResult[int, string](kind: orValue, value: 2)
    check opResult.isValue == true
    check opResult.isMessage == false
    check opResult.value == 2

  test "OpResultWarn message":
    var opResult = OpResult[int, string](kind: orMessage, message: "hello")
    check opResult.isValue == false
    check opResult.isMessage == true
    check opResult.message == "hello"
