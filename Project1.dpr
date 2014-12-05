program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Classes,
  CustomTypes in 'CustomTypes.pas',
  CTSysUtils in 'CTSysUtils.pas',
  GhostAPI in 'GhostAPI.pas';

procedure GSInit(Options: tOptions);
var Rotate,Resample,ColorModel,RAWColorsCounts: array [0..2] of string;
    ColorsPreserveTransfer,JPEGColorscounts,
    PSDColorsCounts,PCLColorsCounts: array [0..1] of string;
    PNGColorscounts,PCXColorscounts: array [0..5] of string;
    BMPColorscounts,TIFFColorscounts: array [0..7] of string;
    PSLanguageLevels: array [0..3] of string;
    PDFDefaultSettings: array [0..4] of string;
begin
  PDFDefaultSettings[0] := 'default';
  PDFDefaultSettings[1] := 'screen';
  PDFDefaultSettings[2] := 'ebook';
  PDFDefaultSettings[3] := 'printer';
  PDFDefaultSettings[4] := 'prepress';

  Rotate[0] := 'None';
  Rotate[1] := 'All';
  Rotate[2] := 'PageByPage';

  Resample[0] := 'Bicubic';
  Resample[1] := 'Subsample';
  Resample[2] := 'Average';

  ColorModel[0] := 'RGB';
  ColorModel[1] := 'CMYK';
  ColorModel[2] := 'Gray';

  ColorsPreserveTransfer[0] := 'Remove';
  ColorsPreserveTransfer[1] := 'Preserve';

  PNGColorscounts[0] := 'png16m';
  PNGColorscounts[1] := 'png256';
  PNGColorscounts[2] := 'png16';
  PNGColorscounts[3] := 'pngmono';
  PNGColorscounts[4] := 'pnggray';
  PNGColorscounts[5] := 'pngalpha';

  JPEGColorscounts[0] := 'jpeg';
  JPEGColorscounts[1] := 'jpeggray';

  BMPColorscounts[0] := 'bmp32b';
  BMPColorscounts[1] := 'bmp16m';
  BMPColorscounts[2] := 'bmp256';
  BMPColorscounts[3] := 'bmp16';
  BMPColorscounts[4] := 'bmpsep8';
  BMPColorscounts[5] := 'bmpsep1';
  BMPColorscounts[6] := 'bmpgray';
  BMPColorscounts[7] := 'bmpmono';

  PCXColorscounts[0] := 'pcxcmyk';
  PCXColorscounts[1] := 'pcx24b';
  PCXColorscounts[2] := 'pcx256';
  PCXColorscounts[3] := 'pcx16';
  PCXColorscounts[4] := 'pcxmono';
  PCXColorscounts[5] := 'pcxgray';

  TIFFColorscounts[0] := 'tiff24nc';
  TIFFColorscounts[1] := 'tiff12nc';
  TIFFColorscounts[2] := 'tiffcrle';
  TIFFColorscounts[3] := 'tiffg3';
  TIFFColorscounts[4] := 'tiffg32d';
  TIFFColorscounts[5] := 'tiffg4';
  TIFFColorscounts[6] := 'tifflzw';
  TIFFColorscounts[7] := 'tiffpack';

  PSLanguageLevels[0] := '1';
  PSLanguageLevels[1] := '1.5';
  PSLanguageLevels[2] := '2';
  PSLanguageLevels[3] := '3';

  PSDColorsCounts[0] := 'psdcmyk';
  PSDColorsCounts[1] := 'psdrgb';
  PCLColorsCounts[0] := 'pxlcolor';
  PCLColorsCounts[1] := 'pxlmono';
  RAWColorsCounts[0] := 'bitcmyk';
  RAWColorsCounts[1] := 'bitrgb';
  RAWColorsCounts[2] := 'bit';

  with Options do
  begin
   GS_PDFDEFAULT := PDFDefaultSettings[PDFGeneralDefault];
   GS_COMPATIBILITY := '1.' + IntToStr(PDFGeneralCompatibility + 2);
   GS_AUTOROTATE := Rotate[PDFGeneralAutorotate];
   GS_OVERPRINT := IntToStr(PDFGeneralOverprint);
   GS_ASCII85 := BoolInt2Str(PDFGeneralASCII85,True);


   GS_COMPRESSPAGES := BoolInt2Str(PDFCompressionTextCompression,True);
   GS_COMPRESSCOLOR := BoolInt2Str(PDFCompressionColorCompression,True);
   GS_COMPRESSGREY := BoolInt2Str(PDFCompressionGreyCompression,True);
   GS_COMPRESSMONO := BoolInt2Str(PDFCompressionMonoCompression,True);

   SelectColorCompression(PDFCompressionColorCompressionChoice);
   SelectGreyCompression(PDFCompressionGreyCompressionChoice);
   SelectMonoCompression(PDFCompressionMonoCompressionChoice);

   GS_COMPRESSCOLORVALUE := BoolInt2Str(PDFCompressionColorCompression,True);
   GS_COMPRESSGREYVALUE := BoolInt2Str(PDFCompressionGreyCompression,True);
   GS_COMPRESSMONOVALUE := BoolInt2Str(PDFCompressionMonoCompression,True);

   GS_COLORRESOLUTION := IntToStr(PDFCompressionColorResolution);
   GS_GREYRESOLUTION := IntToStr(PDFCompressionGreyResolution);
   GS_MONORESOLUTION := IntToStr(PDFCompressionMonoResolution);

   GS_COLORRESAMPLE := BoolInt2Str(PDFCompressionColorResample,True);
   GS_GREYRESAMPLE := BoolInt2Str(PDFCompressionGreyResample,True);
   GS_MONORESAMPLE := BoolInt2Str(PDFCompressionMonoResample,True);

   GS_COLORRESAMPLEMETHOD := Resample[PDFCompressionColorResampleChoice];
   GS_GREYRESAMPLEMETHOD := Resample[PDFCompressionGreyResampleChoice];
   GS_MONORESAMPLEMETHOD := Resample[PDFCompressionMonoResampleChoice];


   GS_EMBEDALLFONTS := BoolInt2Str(PDFFontsEmbedAll,True);
   GS_SUBSETFONTS := BoolInt2Str(PDFFontsSubSetFonts,True);
   GS_SUBSETFONTPERC := IntToStr(PDFFontsSubSetFontsPercent);


   GS_COLORMODEL := ColorModel[PDFColorsColorModel];
   GS_CMYKTORGB := BoolInt2Str(PDFColorsCMYKToRGB,True);
   GS_PRESERVEOVERPRINT := BoolInt2Str(PDFColorsPreserveOverprint,True);
   GS_TRANSFERFUNCTIONS := ColorsPreserveTransfer[PDFColorsPreserveTransfer];
   GS_HALFTONE := BoolInt2Str(PDFColorsPreserveHalftone,True);


   GS_PNGColorscount := PNGColorscounts[PNGColorscount];
   GS_JPEGColorscount := JPEGColorscounts[JPEGColorscount];
   GS_BMPColorscount := BMPColorscounts[BMPColorscount];
   GS_PCXColorscount := PCXColorscounts[PCXColorscount];
   GS_TIFFColorscount := TIFFColorscounts[TIFFColorscount];
   GS_JPEGQuality := IntToStr(JPEGQuality);
   GS_PSLanguageLevel := PSLanguageLevels[PSLanguageLevel];
   GS_EPSLanguageLevel := PSLanguageLevels[EPSLanguageLevel];
   GS_PSDColorscount := PSDColorsCounts[PSDColorsCount];
   GS_PCLColorscount := PCLColorsCounts[PCLColorsCount];
   GS_RAWColorscount := RAWColorsCounts[RAWColorsCount];
  End;
  GS_ERROR := 0;
  UseReturnPipe := 1;
End;

//procedure InitParams();
//begin
//  GSParamsIndex = 0
//  ReDim GSParams(GSParamsIndex)
//End;

function GetGhostscriptResourceString(Options: TOptions): String;
var tStr: String;
    Ghostscript: clsGhostscript;
begin
  Result := '';
  Ghostscript := GetGhostscriptVersion;
  If (Ghostscript.VersionMajor < 8) Or
     ((Ghostscript.VersionMajor = 8) And (Ghostscript.VersionMinor <= 62))
  then
  begin
   If Length(Trim(Options.DirectoryGhostscriptFonts)) > 0 Then
    tStr := tStr + ';' + Trim(Options.DirectoryGhostscriptFonts);
   If Length(Trim(Options.DirectoryGhostscriptResource)) > 0 Then
    tStr := tStr + ';' + Trim(Options.DirectoryGhostscriptResource);
  End;
  Result := tStr;
end;


procedure AddParams(const strValue: String);
begin
  GSParamsIndex := GSParamsIndex + 1;
  SetLength(GSParams,GSParamsIndex);
  GSParams[GSParamsIndex] := strValue;
end;



procedure CallGhostscript(const Comment: String);
var LastStop, c: Currency;
    res: Boolean;
    Ghostscript: clsGhostscript;
    GSParameters: array of string;
    i: Integer;
    UTF8: UTF8String;
begin
//  If PerformanceTimer Then
//    LastStop = ExactTimer_Value()
  Ghostscript := GetGhostscriptVersion;
  SetLength(GSParameters,High(GSParams));
  For i := Low(GSParams) To High(GSParams) do
  begin
   If ((Ghostscript.VersionMajor > 9) Or
      ((Ghostscript.VersionMajor = 9) And (Ghostscript.VersionMinor > 7)))
   then
   begin
     UTF8 := GSParams[i];
     GSParameters[i] := UTF8;
   end
   else
    GSParameters[i] := GSParams[i];
  end;
  res := CallGS(GSParameters);
//  If PerformanceTimer Then
//    c = ExactTimer_Value() - LastStop
//    IfLoggingWriteLogfile "Time for converting [" & Comment & "]: " & _
//    Format$(Int(c) * (1 / 86400), "hh:nn:ss:") & Format$(((c) - Int(c)) * 1000, "000")
//   Else
//    IfLoggingWriteLogfile "Time for converting -> No performance timer [" & Comment & "]"
//  End If
End;


procedure CreatePDFA(const InfoSpoolFileName,PDFDocInfoFile,
                    StampFile,PDFDocViewFile: String; var GSOutputFile: string;
                    Options: tOptions; PDFAFormat: tPDFAFormat);
var tStr: String;
    AdditionalFiles: TStringList;
begin
//  InitParams
//  ParamCommands := New Collection;

  tStr := Options.DirectoryGhostscriptLibraries + GetGhostscriptResourceString(Options);

  If Length(Trim(Options.AdditionalGhostscriptSearchpath)) > 0 Then
   If DirectoryExists(Options.AdditionalGhostscriptSearchpath) Then
    tStr := tStr + ';' + Trim(Options.AdditionalGhostscriptSearchpath);
  AddParams('-I' + tStr);
  If PDFAFormat = PDFA1b Then
    AddParams('-dPDFA=1')
  Else If PDFAFormat = PDFA2b Then
    AddParams('-dPDFA=2')
  Else
    AddParams('-dPDFA');
  AddParams('-q');
  AddParams('-dNOPAUSE');
  AddParams('-dBATCH');
  If (Length(GetFontsDirectory) > 0) And (Options.AddWindowsFontpath = 1) Then
   AddParams('-sFONTPATH=' + GetFontsDirectory);
  AddParams('-sDEVICE=pdfwrite');
  If Options.DontUseDocumentSettings = 0 Then
  begin
   AddParams('-dPDFSETTINGS=/' + GS_PDFDEFAULT);
   AddParams('-dCompatibilityLevel=' + GS_COMPATIBILITY);
   AddParams('-dNOOUTERSAVE');
   AddParams('-dUseCIEColor');
   AddParams('-sProcessColorModel=Device' + GS_COLORMODEL);
   AddParams('-dAutoRotatePages=/' + GS_AUTOROTATE);
   AddParams('-dCompressPages=' + GS_COMPRESSPAGES);
   AddParams('-dEmbedAllFonts=true');
   AddParams('-dSubsetFonts=' + GS_SUBSETFONTS);
   AddParams('-dMaxSubsetPct=100');
   AddParams('-dConvertCMYKImagesToRGB=' + GS_CMYKTORGB);

   If Options.UseFixPapersize <> 0 Then
     If Options.UseCustomPaperSize = '0' Then
     begin
       If Length(Trim(Options.Papersize)) > 0 Then
       begin
        AddParams('-sPAPERSIZE=' + LowerCase(Trim(Options.Papersize)));
        AddParams('-dFIXEDMEDIA');
        AddParams('-dNORANGEPAGESIZE');
       End;
     end
     Else
     begin
       If Options.DeviceWidthPoints >= 1 Then
         AddParams('-dDEVICEWIDTHPOINTS=' + FloatToStr(Options.DeviceWidthPoints));
       If Options.DeviceHeightPoints >= 1 Then
         AddParams('-dDEVICEHEIGHTPOINTS=' + FloatToStr(Options.DeviceHeightPoints));
     End;
  end;

  If (Options.AllowSpecialGSCharsInFilenames = 1) And (Options.OneFilePerPage <> 1) Then
    GSOutputFile := StringReplace(GSOutputFile, '%', '%%', [rfReplaceAll, rfIgnoreCase]);
  AddParams('-sOutputFile=' + GSOutputFile);

  If Options.DontUseDocumentSettings = 0 Then
  begin
//   SetColorParams;
//   SetGreyParams;
//   SetMonoParams;

   AddParams('-dPreserveOverprintSettings=' + GS_PRESERVEOVERPRINT);
   AddParams('-dUCRandBGInfo=/Preserve');
   AddParams('-dUseFlateCompression=true');
   AddParams('-dParseDSCCommentsForDocInfo=true');
   AddParams('-dParseDSCComments=true');
   AddParams('-dOPM=1' + GS_OVERPRINT);
   AddParams('-dOffOptimizations=0');
   AddParams('-dLockDistillerParams=false');
   AddParams('-dGrayImageDepth=-1');
   AddParams('-dASCII85EncodePages=' + GS_ASCII85);
   AddParams('-dDefaultRenderingIntent=/Default');
   AddParams('-dTransferFunctionInfo=/' + GS_TRANSFERFUNCTIONS);
   AddParams('-dPreserveHalftoneInfo=' + GS_HALFTONE);
   AddParams('-dDetectBlends=true');

//   AddAdditionalGhostscriptParameters;
//
//   AddParamCommands;
  End;

  AdditionalFiles := TStringList.Create;
  AdditionalFiles.Add(PDFDocInfoFile);
  AdditionalFiles.Add(StampFile);
  AdditionalFiles.Add(PDFDocViewFile);

//  AddInputFiles(InfoSpoolFileName, AdditionalFiles);
//
//  ShowParams;
  CallGhostscript('PDF/A (without encryption)');
end;



procedure CallGScript(GSInfoSpoolFile: String; GSOutputFile: String; Options: tOptions;
         Ghostscriptdevice: tGhostscriptDevice; PDFDocInfoFile: String;
         StampFile: String; PDFDocViewFile: String; PDFAFormat: tPDFAFormat = PDFA2b);
var enc: Boolean;
    encPDF: EncryptData;
    retEnc: Boolean;
    Tempfile: String;
    tL: LongInt;
    m: TObject;
    Ghostscript: clsGhostscript;
begin
  GSInit(Options);

  Case Ghostscriptdevice of
    PDFAWriter: begin //PDFA
                 CreatePDFA(GSInfoSpoolFile, PDFDocInfoFile, StampFile,
                            PDFDocViewFile, GSOutputFile, Options,
                            PDFAFormat);
////                 If DotNet20Installed And pdfforgeDllInstalled Then
////                   If Options.PDFUpdateMetadata > 0 Then
////                   begin
////                     m := CreateObject('pdfForge.pdf.pdf');
////                     Tempfile := GetTempFile(GetTempPathApi, '~MP');
////                     KillFile(Tempfile);
////                     m.UpdateXMPMetadata(GSOutputFile, Tempfile);
////                     If FileExists(Tempfile) then
////                       If KillFile(GSOutputFile) then
////                         Name(Tempfile As GSOutputFile);
////                   end;
////                 If Options.PDFSigningSignPDF = 1 then
////                   SignPDF(GSOutputFile);
                end;
  End;
End;

Function CreatePDFDocInfoFile(InfoSpoolFile: String; PDFDocInfo: tPDFDocInfo): string;
var fn: LongInt;
    MetadataString, DocInfoStr, Path, aFile, PDFDocInfoFile: String;
begin
  MetadataString := GetMetadataString(PDFDocInfo);
  SplitPath(InfoSpoolFile,'',Path,'',aFile);
  PDFDocInfoFile := CompletePath(Path) + aFile + '.mtd';
  If FileExists(InfoSpoolFile) And (Length(MetadataString) > 0) Then
  begin
    DocInfoStr := #13 + '/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse';
    DocInfoStr := DocInfoStr + #13 + '[';
    DocInfoStr := DocInfoStr + #13 + MetadataString;
    DocInfoStr := DocInfoStr + #13 + '/DOCINFO pdfmark';
    DocInfoStr := DocInfoStr + #13 + '%%EOF';
    fn := FreeFile;
//    Open PDFDocInfoFile For Output As fn
//    Print #fn, DocInfoStr;
//    Close #fn
    Result := PDFDocInfoFile;
//    End;
  end;
End;



Function CreatePDFDocViewFile(InfoSpoolFile: String; PageLayout, PageMode, StartPage: Integer): string;
var fn: Integer;
    DocViewStr, Path, aFile, PDFDocViewFile: String;
begin
  If (PageLayout > 0) Or (PageMode > 0) Or (StartPage <> 1) Then
   SplitPath InfoSpoolFile, , Path, , File
   PDFDocViewFile = CompletePath(Path) & File & ".dvw"
   If FileExists(InfoSpoolFile) = True Then
    DocViewStr = Chr$(13) & "/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse"
    DocViewStr = DocViewStr & Chr$(13) & "["
    If PageLayout > 0 Then
     DocViewStr = DocViewStr & Chr$(13) & "/PageLayout"
     Select Case PageLayout
           Case 1:
       DocViewStr = DocViewStr & " /OneColumn"
      Case 2:
       DocViewStr = DocViewStr & " /TwoColumnLeft"
      Case 3:
       DocViewStr = DocViewStr & " /TwoColumnRight"
      Case 4:
       DocViewStr = DocViewStr & " /TwoPageLeft"
      Case 5:
       DocViewStr = DocViewStr & " /TwoPageRight"
      Case Else:
       DocViewStr = DocViewStr & " /SinglePage"
     End Select
    End If
    If PageMode > 0 Then
     DocViewStr = DocViewStr & Chr$(13) & "/PageMode"
     Select Case PageMode
           Case 1:
       DocViewStr = DocViewStr & " /UseOutlines"
      Case 2:
       DocViewStr = DocViewStr & " /UseThumbs"
      Case 3:
       DocViewStr = DocViewStr & " /FullScreen"
      Case 4:
       DocViewStr = DocViewStr & " /UseOC"
      Case 5:
       DocViewStr = DocViewStr & " /UseAttachments"
      Case Else:
       DocViewStr = DocViewStr & " /UseNone"
     End Select
    End If
    If StartPage > 1 Then
     DocViewStr = DocViewStr & " /Page " & CStr(StartPage)
    End If
    DocViewStr = DocViewStr & Chr$(13) & "/DOCVIEW pdfmark"
    DocViewStr = DocViewStr & Chr$(13) & "%%EOF"
    fn = FreeFile
    Open PDFDocViewFile For Output As fn
    Print #fn, DocViewStr;
    Close #fn
    CreatePDFDocViewFile = PDFDocViewFile
   End If
  End If
End;


Public Function CreateStampFile(InfoSpoolFileName As String) As String
'---ErrPtnr-OnError-START--- DO NOT MODIFY ! ---
On Error GoTo ErrPtnr_OnError
'---ErrPtnr-OnError-END--- DO NOT MODIFY ! ---
50010  Dim StampPage As String, tStr As String, R As String, G As String, b As String, Path As String, ff As Long, _
  StampFile As String, StampString As String, StampFontsize As Double, StampOutlineFontthickness As Double
50030  Dim File As String
50040  StampString = RemoveLeadingAndTrailingQuotes(Trim$(Options.StampString))
50050  If Len(StampString) > 0 Then
50060   StampPage = StrConv(LoadResData(101, "STAMPPAGE"), vbUnicode)
50070   StampPage = Replace(StampPage, vbCrLf, vbCr, , , vbBinaryCompare)
50080   StampPage = Replace(StampPage, "[STAMPSTRING]", EncodeCharsOctal(StampString), , , vbTextCompare)
50090   StampPage = Replace(StampPage, "[FONTNAME]", Replace(Trim$(Options.StampFontname), " ", ""), , , vbTextCompare)
50100   StampFontsize = 48
50110   If IsNumeric(Options.StampFontsize) = True Then
50120    If CDbl(Options.StampFontsize) > 0 Then
50130     StampFontsize = CDbl(Options.StampFontsize)
50140    End If
50150   End If
50160   StampPage = Replace(StampPage, "[FONTSIZE]", StampFontsize, , , vbTextCompare)
50170   StampOutlineFontthickness = 0
50180   If IsNumeric(Options.StampOutlineFontthickness) = True Then
50190    If CDbl(Options.StampOutlineFontthickness) >= 0 Then
50200     StampOutlineFontthickness = CDbl(Options.StampOutlineFontthickness)
50210    End If
50220   End If
50230   StampPage = Replace(StampPage, "[STAMPOUTLINEFONTTHICKNESS]", StampOutlineFontthickness, , , vbTextCompare)
50240   If Options.StampUseOutlineFont <> 1 Then
50250     StampPage = Replace(StampPage, "[USEOUTLINEFONT]", "show", , , vbTextCompare)
50260    Else
50270     StampPage = Replace(StampPage, "[USEOUTLINEFONT]", "true charpath stroke", , , vbTextCompare)
50280   End If
50290   If Len(Options.StampFontColor) > 0 Then
50300     tStr = Replace$(Options.StampFontColor, "#", "&H")
50310     If IsNumeric(tStr) = True Then
50320       R = Replace$(Format(CDbl((CLng(tStr) And CLng("&HFF0000")) / 65536) / 255#, "0.00"), ",", ".", , 1)
50330       G = Replace$(Format(CDbl((CLng(tStr) And CLng("&H00FF00")) / 256) / 255#, "0.00"), ",", ".", , 1)
50340       b = Replace$(Format(CDbl(CLng(tStr) And CLng("&H0000FF")) / 255#, "0.00"), ",", ".", , 1)
50350       StampPage = Replace(StampPage, "[FONTCOLOR]", R & " " & G & " " & b, , , vbTextCompare)
50360      Else
50370       StampPage = Replace(StampPage, "[FONTCOLOR]", "1 0 0", , , vbTextCompare)
50380     End If
50390    Else
50400     StampPage = Replace(StampPage, "[FONTCOLOR]", "1 0 0", , , vbTextCompare)
50410   End If
50420   SplitPath InfoSpoolFileName, , Path, , File
50430   StampFile = CompletePath(Path) & File & ".stm"
50440   ff = FreeFile
50450   Open StampFile For Output As #ff
50460   Print #ff, StampPage
50470   Close #ff
50480   CreateStampFile = StampFile
50490  End If
'---ErrPtnr-OnError-START--- DO NOT MODIFY ! ---
Exit Function
ErrPtnr_OnError:
Select Case ErrPtnr.OnError("modGhostScript", "CreateStampFile")
Case 0: Resume
Case 1: Resume Next
Case 2: Exit Function
Case 3: End
End Select
'---ErrPtnr-OnError-END--- DO NOT MODIFY ! ---
End Function



var Options: tOptions;
    PDFDocInfoFile,StampFile: string;

begin
  try
    Fillchar(Options,sizeof(tOptions),0);
    PDFDocInfoFile = CreatePDFDocInfoFile(InfoSpoolFileName, PDFDocInfo);
    StampFile = CreateStampFile(InfoSpoolFileName);

    CallGScript('J:\Work\Документ+подписан+электронной+ци.doc',
                'J:\Work\Документ+подписан+электронной+ци.pdf', Options,
                PDFAWriter, PDFDocInfoFile, StampFile,
>>>>>>> origin/master
                PDFDocViewFile);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
