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

implementation
uses SysUtils, Registry, Windows;

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



end.
