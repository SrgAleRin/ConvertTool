unit CTSysUtils;

interface
uses CustomTypes;

  procedure SelectColorCompression(Value: Integer);
  procedure SelectGreyCompression(Value: Integer);
  procedure SelectMonoCompression(Value: integer);
  function BoolInt2Str(Value: Integer; UseBoolStr: Boolean = True): string;
  function GetGhostscriptVersion(): clsGhostscript;
  Function GetFontsDirectory(): String;
  Function DotNet20Installed(): Boolean;
  Function pdfforgeDllIsInstalled(): Boolean;
  function EncodeChars(CodePage: LongInt; Keyword: string): string;
  function InStrRev(ASource, ToFind: String): Integer;

implementation
uses SysUtils, Registry, Windows, Classes, System.StrUtils;

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

Function AdjustCultureCalendar(dateStr: String): String;
var
  pcLCA: array [0..20] of Char;
begin
  If GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_ICALENDARTYPE,pcLCA,19) = 7 Then
    dateStr := IntToStr(Length(Copy(dateStr, 1, 4)) - 543);
  Result := dateStr;
End;

Function GetMetadataString(PDFDocInfo: tPDFDocInfo): String;
var PDFDocInfoStr,tStr,ttStr: String;
//    tzi: clsTimeZoneInformation;
    CodePage: LongInt;
begin
  CodePage := Integer(eCodePage.CP_UTF16);
  With PDFDocInfo do
  begin
    PDFDocInfoStr := PDFDocInfoStr + #13;
    If Length(Trim(Author)) > 0 Then
      tStr := EncodeChars(CodePage, Author)
    Else
      tStr := '()';

    PDFDocInfoStr := PDFDocInfoStr + #13 + '/Author ' + tStr;
    If (Length(CreationDate) > 0) Or (Length(ModifyDate) > 0) Then
    begin
//    Set tzi = New clsTimeZoneInformation
//    If tzi.DayLight Then
//      ttStr = Format(TimeSerial(0, tzi.DaylightToGMT, 0), "hh'mm'")
//    Else
//      ttStr = Format(TimeSerial(0, tzi.NormaltimeToGMT, 0), "hh'mm'");

//    If tzi.DaylightToGMT >= 0 Then
//      ttStr = '+' + ttStr
//    Else
//      ttStr = '-' + ttStr;
    End;

    If Length(Trim(CreationDate)) > 0 Then
      tStr := '(D:' + AdjustCultureCalendar(CreationDate) + ttStr + ')'
    Else
      tStr := '()';

    PDFDocInfoStr := PDFDocInfoStr + #13 + '/CreationDate ' + tStr;
    If Length(Creator) > 0 Then
      tStr := EncodeChars(CodePage, Creator)
    Else
      tStr := '()';

    PDFDocInfoStr := PDFDocInfoStr + #13 + '/Creator ' + tStr;
    If Length(Trim(Keywords)) > 0 Then
      tStr := EncodeChars(CodePage, Keywords)
    Else
      tStr := '()';

    PDFDocInfoStr := PDFDocInfoStr + #13 + '/Keywords ' + tStr;
    If Length(Trim(ModifyDate)) > 0 Then
      tStr := '(D:' + AdjustCultureCalendar(ModifyDate) + ttStr + ')'
    Else
      tStr := '()';

    PDFDocInfoStr := PDFDocInfoStr + #13 + '/ModDate ' + tStr;
//    If (Length(CreationDate) > 0) Or (Length(ModifyDate) > 0) Then
//      Set tzi = Nothing

    If Length(Trim(Subject)) > 0 Then
      tStr := EncodeChars(CodePage, Subject)
    Else
      tStr := '()';

    PDFDocInfoStr := PDFDocInfoStr + #13 + '/Subject ' + tStr;
    If Length(Trim(Title)) > 0 Then
      tStr := EncodeChars(CodePage, Title)
    Else
      tStr := '()';

    PDFDocInfoStr := PDFDocInfoStr + #13 + '/Title ' + tStr;
  End;
  Result := PDFDocInfoStr;
End;


function EncodeChars(CodePage: LongInt; Keyword: string): string;
var LBytes,RBytes: TBytes;
    Ansi,Code: TEncoding;
begin
  Result := '';
  Ansi := TEncoding.ANSI.Create;
  try
    Code := TEncoding.GetEncoding(CodePage).Create;
    try
      LBytes := Ansi.GetBytes(Keyword);
      RBytes := TEncoding.Convert(Ansi,Code,LBytes);
      Result := Code.GetString(RBytes);
    finally
      Code.Free;
    end;
  finally
    Ansi.Free;
  end;
end;

function InStrRev(ASource, ToFind: String): Integer;
var
 i: Integer;
begin
  for i := Length(ASource) downto 1 do
  if PosEx(ToFind, ASource, i) <> 0 then
  begin
    Result := PosEx(ToFind, ASource, i);
    Break;
  end;
end;


procedure SplitPath(FullPath: String; Drive: String=''; Path: String=''; filename: String='';
                    aFile: String=''; Extension: String='');
var nPos: Integer;
begin
  nPos := InStrRev(FullPath, '\');
  If nPos > 0 Then
  begin
    If Copy(FullPath,1, 2) = '\\' Then
      If nPos = 2 Then
      begin
        Drive := FullPath;
        Path := '';
        filename := '';
        aFile := '';
        Extension := '';
        Exit;
      End;

    Path := Copy(FullPath,1, nPos - 1);
    filename := Copy(FullPath, nPos + 1, Length(FullPath));
    nPos := InStrRev(filename, '.');
    If nPos > 0 Then
    begin
      aFile := Copy(filename,1, nPos - 1);
      Extension := Copy(filename, nPos + 1,Length(filename));
    end
    Else
    begin
      aFile := filename;
      Extension := '';
    End;

    nPos := InStrRev(FullPath, ':');
    If nPos > 0 Then
    begin
      Path := Copy(FullPath, 1, nPos - 1);
      filename := Copy(FullPath, nPos + 1, Length(filename));
      nPos := InStrRev(filename, '.');
      If nPos > 0 Then
      begin
        aFile := Copy(filename,1, nPos - 1);
        Extension := Copy(filename, nPos + 1, Length(filename));
      end
      Else
      begin
        aFile := filename;
        Extension := '';
      end;
    End
    Else
    begin
      Path := '';
      filename := FullPath;
      nPos := InStrRev(filename, '.');
      If nPos > 0 Then
      begin
        aFile := Copy(filename,1, nPos - 1);
        Extension := Copy(filename, nPos + 1, Length(filename));
      end
      Else
      begin
        aFile := filename;
        Extension := '';
      end;
    End;
  end
  else If Copy(Path,1, 2) = '\\' Then
  begin
    nPos := PosEx('\', Path, 3);
    If nPos>0 Then
      Drive := Copy(Path,1, nPos - 1)
    Else
      Drive := Path;
  end
  Else
  begin
    If Length(Path) = 2 Then
      If Copy(Path,Length(Path)-2, 1) = ':' Then
        Path := Path + '\';
    If Copy(Path, 2, 2) = ':\' Then
      Drive := Copy(Path,1, 2);
  End;
End;




end.
