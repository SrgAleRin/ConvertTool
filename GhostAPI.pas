unit GhostAPI;

interface

Function CallGS(astrGSArgs: array of string): Boolean;

implementation
uses SysUtils;

var GS_OutStr: String;
    gsStr1: String;

//------------------------------------------------
//API Calls Start
//------------------------------------------------
//GhostScript API

Const GsDll = 'gsdll32.dll';

Function gsapi_revision(pGSRevisionInfo: Longint; intLen: Longint): Longint; external GsDll;
Function gsapi_new_instance(lngGSInstance: Longint; lngCallerHandle: Longint): Longint; external GsDll;
Function gsapi_set_stdio(lngGSInstance: Longint; gsdll_stdin: Pointer;
                         gsdll_stdout: Pointer; gsdll_stderr: Pointer): Longint; external GsDll;
procedure gsapi_delete_instance(lngGSInstance: Longint); external GsDll;
Function gsapi_init_with_args(lngGSInstance: Longint; lngArgumentCount: Longint;
                              lngArguments: Longint): Longint; external GsDll;
Function gsapi_run_file(lngGSInstance: Longint; strFileName: widestring;
                        intErrors: Longint; intExitCode: Longint): Longint; external GsDll;
Function gsapi_exit(lngGSInstance: Longint): Longint; external GsDll;

//------------------------------------------------
//API Calls End
//------------------------------------------------

Function gsdll_stdin(intGSInstanceHandle: Longint; strz: Longint; intBytes: Longint): Longint;
begin
  Result := 0
End;

Function gsdll_stdout(intGSInstanceHandle: Longint; strz: Longint; intBytes: Longint): Longint;
var aByte: array of Byte;
    ptrByte: Pointer;
    tStr,Ustr: String;
begin
  SetLength(aByte,intBytes);
  ptrByte := @aByte[0];
  Move(ptrByte, strz, intBytes);
  SetString(Ustr, PChar(@aByte[0]), intBytes div SizeOf(Char));
  tStr := StringReplace(Ustr, #10, #13#10, [rfReplaceAll,rfIgnoreCase]);
  If (LowerCase(Copy(tStr, 1, 4)) <> 'svg_') And (LowerCase(Copy(tStr, 1, 6)) <> 'type 1') then
   GS_OutStr := GS_OutStr + tStr;
  result := intBytes;
End;

Function gsdll_stderr(intGSInstanceHandle: Longint; strz: Longint; intBytes: Longint): Longint;
begin
  Result := gsdll_stdout(intGSInstanceHandle, strz, intBytes);
End;


Function CallGS(astrGSArgs: array of string): Boolean;
var intReturn,intGSInstanceHandle,
    intCounter,intElementCount,callerHandle: Integer;
    ptrArgs: Pointer;
    aAnsiArgs: array of String;
    aPtrArgs: array of PChar;
begin
//     ' Print out the revision details.
//     ' If we want to insist on a particular version of Ghostscript
//     ' we should check the return value of CheckRevision().
//     'CheckRevision (705)

//     ' Load Ghostscript and get the instance handle
  GS_OutStr := '';
  gsStr1 := #0 + #10 + #13;
  intReturn := gsapi_new_instance(intGSInstanceHandle, callerHandle);
  If (intReturn < 0) Then
  begin
    CallGS := False;
    Exit;
  end;

  intReturn := gsapi_set_stdio(intGSInstanceHandle, @gsdll_stdin, @gsdll_stdout, @gsdll_stderr);

  If (intReturn >= 0) Then
  begin
    intElementCount := High(astrGSArgs);
    SetLength(aAnsiArgs,intElementCount);
    SetLength(aPtrArgs,intElementCount);
    For intCounter := 0 To intElementCount do
    begin
      aAnsiArgs[intCounter] := astrGSArgs[intCounter];
      aPtrArgs[intCounter] := PChar(aAnsiArgs[intCounter]);
    end;
    ptrArgs := @aPtrArgs[0];
    intReturn := gsapi_init_with_args(intGSInstanceHandle, intElementCount + 1, integer(ptrArgs));
    gsapi_exit(intGSInstanceHandle);
  end;

  gsapi_delete_instance (intGSInstanceHandle);
  If (intReturn >= 0) Then
   CallGS := True
  Else
   CallGS := False;
End;



end.
