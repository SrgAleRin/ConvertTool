unit CTSysUtils;

interface
uses CustomTypes;

  procedure SelectColorCompression(Value: Integer);
  procedure SelectGreyCompression(Value: Integer);
  procedure SelectMonoCompression(Value: integer);
  function BoolInt2Str(Value: Integer; UseBoolStr: Boolean = True): string;
  function GetGhostscriptVersion(): clsGhostscript;
  Function GetFontsDirectory(): String;
<<<<<<< HEAD
  Function DotNet20Installed(): Boolean;
  Function pdfforgeDllIsInstalled(): Boolean;
=======
>>>>>>> origin/master

implementation
uses SysUtils, Registry, Windows, Classes;

procedure SelectColorCompression(Value: Integer);
begin
  GS_COMPRESSCOLORAUTO := 'false';
  Case Value of
    0: begin
         GS_COMPRESSCOLORAUTO := 'true';
         GS_COMPRESSCOLORMETHOD := 'null';
         GS_COMPRESSCOLORLEVEL := 'null';
       end;
    1: begin
         GS_COMPRESSCOLORMETHOD := 'DCTEncode';
         GS_COMPRESSCOLORLEVEL := 'Maximum';
       end;
    2: begin
         GS_COMPRESSCOLORMETHOD := 'DCTEncode';
         GS_COMPRESSCOLORLEVEL := 'High';
       end;
    3: begin
         GS_COMPRESSCOLORMETHOD := 'DCTEncode';
         GS_COMPRESSCOLORLEVEL := 'Medium';
       end;
    4: begin
         GS_COMPRESSCOLORMETHOD := 'DCTEncode';
         GS_COMPRESSCOLORLEVEL := 'Low';
       end;
    5: begin
         GS_COMPRESSCOLORMETHOD := 'DCTEncode';
         GS_COMPRESSCOLORLEVEL := 'Minimum';
       end;
    6: begin
         GS_COMPRESSCOLORMETHOD := 'FlateEncode';
         GS_COMPRESSCOLORLEVEL := 'Maximum';
       end;
  End;
End;

procedure SelectGreyCompression(Value: Integer);
begin
  GS_COMPRESSGREYAUTO := 'false';
  Case Value of
    0: begin
         GS_COMPRESSGREYAUTO := 'true';
         GS_COMPRESSGREYMETHOD := 'null';
         GS_COMPRESSGREYLEVEL := 'null';
       end;
    1: begin
         GS_COMPRESSGREYMETHOD := 'DCTEncode';
         GS_COMPRESSGREYLEVEL := 'Maximum';
       end;
    2: begin
         GS_COMPRESSGREYMETHOD := 'DCTEncode';
         GS_COMPRESSGREYLEVEL := 'High';
       end;
    3: begin
         GS_COMPRESSGREYMETHOD := 'DCTEncode';
         GS_COMPRESSGREYLEVEL := 'Medium';
       end;
    4: begin
         GS_COMPRESSGREYMETHOD := 'DCTEncode';
         GS_COMPRESSGREYLEVEL := 'Low';
       end;
    5: begin
         GS_COMPRESSGREYMETHOD := 'DCTEncode';
         GS_COMPRESSGREYLEVEL := 'Minimum';
       end;
    6: begin
         GS_COMPRESSGREYMETHOD := 'FlateEncode';
         GS_COMPRESSGREYLEVEL := 'Maximum';
       end;
  End;
End;

procedure SelectMonoCompression(Value: integer);
begin
  Case Value of
    0: begin
         GS_COMPRESSMONOMETHOD := 'CCITTFaxEncode';
       end;
    1: begin
         GS_COMPRESSMONOMETHOD := 'FlateEncode';
       end;
    2: begin
         GS_COMPRESSMONOMETHOD := 'RunLengthEncode';
       end;
    3: begin
         GS_COMPRESSMONOMETHOD := 'LZWEncode';
       end;
  End;
End;

function BoolInt2Str(Value: Integer; UseBoolStr: Boolean = True): string;
begin
  Result := 'False';
  if UseBoolStr then
  begin
    if Value = 1 then
      Result := 'True'
    else
      Result := 'False';
  end;
end;


function GetGhostscriptVersion(): clsGhostscript;
var gsRev, tStr: String;
    Major, Minor: Integer;
begin
  gsRev := IntToStr(GSRevision.intRevision);
  FillChar(Result,SizeOf(Result),#0);
  Minor := 0;
  Major := 0;
  if Length(gsRev) >= 3 then
  begin
   tStr := Copy(gsRev, Length(gsRev) - 1, 2);
   TryStrToInt(tStr,Minor);
   tStr := Copy(gsRev, 1, Length(gsRev) - 2);
   TryStrToInt(tStr,Major);
   Result.VersionMajor := Major;
   Result.VersionMinor := Minor;
  end;
end;

Function GetFontsDirectory(): String;
var reg: TRegistry;
    tStr: String;
    WinDir: array [0..255] of Char;
begin
  tStr := '';
  reg := TRegistry.Create;
  try
    if reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',False) then
      tStr := reg.ReadString('Fonts');
  finally
    reg.Free;
  end;
  If tStr = '' Then
  begin
    GetWindowsDirectory(WinDir,SizeOf(WinDir));
    tStr := WinDir + '\Fonts';
  end;
  Result := tStr;
End;

<<<<<<< HEAD
Function DotNet20Installed(): Boolean;
begin
  Result := DirectoryExists(GetEnvironmentVariable('WinDir') + 'Microsoft.NET\Framework\v2.0.50727');
End;

Function pdfforgeDllIsInstalled(): Boolean;
begin
  Result := False;
//  If FileExists(PDFCreatorApplicationPath + 'PlugIns\pdfforge\pdfforge.dll') And
//     FileExists(PDFCreatorApplicationPath + 'PlugIns\pdfforge\itextsharp.dll')
//  Then
//    Result := True;
End;
=======
Function GetMetadataString(PDFDocInfo: tPDFDocInfo): String;
var PDFDocInfoStr,tStr,ttStr: String;
//    tzi: clsTimeZoneInformation;
    CodePage: LongInt;
    LBytes,RBytes: TBytes;
    Ansi,Code: TEncoding;
begin
  CodePage := eCodePage.CP_UTF16;
  With PDFDocInfo do
  begin
   PDFDocInfoStr := PDFDocInfoStr + #13;
   If Length(Trim(Author)) > 0 Then
   begin
     Ansi := TEncoding.ANSI.Create;
     Code := TEncoding.GetEncoding(CodePage).Create;
     LBytes := Ansi.GetBytes(Author);
     RBytes := TEncoding.Convert(Ansi,Code,LBytes);
     tStr := Code.GetString(RBytes);
   end
   Else
     tStr := '()';

   PDFDocInfoStr := PDFDocInfoStr + #13 + '/Author ' + tStr;
   If (Length(CreationDate) > 0) Or (Length(ModifyDate) > 0) Then
   begin
//    Set tzi = New clsTimeZoneInformation
    If tzi.DayLight Then
      ttStr = Format(TimeSerial(0, tzi.DaylightToGMT, 0), "hh'mm'")
    Else
      ttStr = Format(TimeSerial(0, tzi.NormaltimeToGMT, 0), "hh'mm'");

    If tzi.DaylightToGMT >= 0 Then
      ttStr = '+' + ttStr
    Else
      ttStr = '-' + ttStr;
   End;

   If Length(Trim(CreationDate)) > 0 Then
     tStr := '(D:' + AdjustCultureCalendar(CreationDate) + ttStr + ')'
   Else
     tStr := '()';

   PDFDocInfoStr = PDFDocInfoStr & Chr$(13) & "/CreationDate " & tStr
   If LenB(.Creator) > 0 Then
     tStr = EncodeChars(CodePage, .Creator)
    Else
     tStr = "()"
   End If
   PDFDocInfoStr = PDFDocInfoStr & Chr$(13) & "/Creator " & tStr
   If LenB(Trim$(.Keywords)) > 0 Then
     tStr = EncodeChars(CodePage, .Keywords)
    Else
     tStr = "()"
   End If
   PDFDocInfoStr = PDFDocInfoStr & Chr$(13) & "/Keywords " & tStr
   If LenB(Trim$(.ModifyDate)) > 0 Then
     tStr = "(D:" & AdjustCultureCalendar(.ModifyDate) & ttStr & ")"
    Else
     tStr = "()"
   End If
   PDFDocInfoStr = PDFDocInfoStr & Chr$(13) & "/ModDate " & tStr
   If LenB(.CreationDate) > 0 Or LenB(.ModifyDate) > 0 Then
    Set tzi = Nothing
   End If
   If LenB(Trim$(.Subject)) > 0 Then
     tStr = EncodeChars(CodePage, .Subject)
    Else
     tStr = "()"
   End If
   PDFDocInfoStr = PDFDocInfoStr & Chr$(13) & "/Subject " & tStr
   If LenB(Trim$(.Title)) > 0 Then
     tStr = EncodeChars(CodePage, .Title)
    Else
     tStr = "()"
   End If
   PDFDocInfoStr = PDFDocInfoStr & Chr$(13) & "/Title " & tStr
  End With
  end;
  GetMetadataString = PDFDocInfoStr
End;


>>>>>>> origin/master



end.
