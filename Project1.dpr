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
    PDFAWriter:
       begin //PDFA
         CreatePDFA(GSInfoSpoolFile, PDFDocInfoFile, StampFile, PDFDocViewFile,
                    GSOutputFile, Options, PDFAFormat);
         If DotNet20Installed And pdfforgeDllIsInstalled Then
           If Options.PDFUpdateMetadata > 0 Then
           begin
//             m := CreateObject('pdfForge.pdf.pdf');
//             Tempfile := GetTempFile(GetTempPathApi, '~MP');
//             KillFile(Tempfile);
//             m.UpdateXMPMetadata(GSOutputFile, Tempfile);
//             If FileExists(Tempfile) then
//               If KillFile(GSOutputFile) then
//                 Name(Tempfile As GSOutputFile);
           end;
//         If Options.PDFSigningSignPDF = 1 then
//           SignPDF(GSOutputFile);
       end;
  End;
End;

procedure ConvertFile(const InputFilename, OutputFilename: String; SubFormat: String = '');
begin
  Dim Ext As String, ivgf As Boolean, inFile As String, File As String, psFileName As String
  Dim InfoSpoolFileName As String, PDFDocInfoFile As String, StampFile As String, PDFDocViewFile As String
  Dim PDFDocInfo As tPDFDocInfo, tDate As Date
  Dim PSHeader As tPSHeader, dateStr As String, strGUID As String
  Dim dateCreated As Date, dateAccessed As Date, dateWritten As Date
  Dim isf As clsInfoSpoolFile

  IFIsPS = False
  If LenB(InputFilename) = 0 Then
   Exit Sub
  End If
  If FileExists(InputFilename) = False Then
   If LenB(InputFilename) > 0 Then
    MsgBox LanguageStrings.MessagesMsg14 & vbCrLf & vbCrLf & _
    "InputFile -IF" & vbCrLf & ">" & InputFilename & "<", vbExclamation + vbOKOnly
   End If
   Exit Sub
  End If
  ivgf = IsValidGraphicFile(InputFilename)
  If LenB(OutputFilename) > 0 Then
    tDate = Now
    dateStr = CStr(tDate)
    If IsPostscriptFile(InputFilename) = True Or ivgf Or IsPDFFile(InputFilename) Then
      If GsDllLoaded = 0 Then
       Exit Sub
      End If
      GsDllLoaded = LoadDLL(CompletePath(Options.DirectoryGhostscriptBinaries) & GsDll)
      If GsDllLoaded = 0 Then
       MsgBox LanguageStrings.MessagesMsg08
      End If
      inFile = InputFilename
      strGUID = GetGUID
      File = GetPDFCreatorSpoolDirectory & strGUID
      If ivgf Then
       psFileName = File & ".ps"
       If Image2PS(InputFilename, psFileName) Then
         inFile = psFileName
        Else
         IfLoggingWriteLogfile "ConvertFile: There is a problem converting '" & InputFilename & "'!"
         Exit Sub
       End If
      End If
      InfoSpoolFileName = CreateInfoSpoolFile(inFile, File & ".inf", , , , , , , , False)
      If IsPostscriptFile(inFile) = True Then
        PSHeader = GetPSHeader(inFile)
        If LenB(PSHeader.CreationDate.Comment) > 0 Then
         dateStr = FormatPrintDocumentDate(PSHeader.CreationDate.Comment)
        End If
       Else
        If GetFileTimes(inFile, dateCreated, dateAccessed, dateWritten, True) Then
         dateStr = CStr(dateCreated)
        End If
      End If
     Else
      InfoSpoolFileName = InputFilename
      inFile = InputFilename
      If LenB(InfoSpoolFileName) > 0 Then
       Set isf = New clsInfoSpoolFile
       isf.ReadInfoFile InfoSpoolFileName
       If LenB(isf.FirstSpoolFileName) > 0 Then
        If IsPostscriptFile(isf.FirstSpoolFileName) = True Then
          PSHeader = GetPSHeader(isf.FirstSpoolFileName)
          If LenB(PSHeader.CreationDate.Comment) > 0 Then
            dateStr = FormatPrintDocumentDate(PSHeader.CreationDate.Comment)
           Else
            If GetFileTimes(isf.FirstSpoolFileName, dateCreated, dateAccessed, dateWritten, True) Then
             dateStr = CStr(dateCreated)
            End If
          End If
         Else
          If GetFileTimes(isf.FirstSpoolFileName, dateCreated, dateAccessed, dateWritten, True) Then
           dateStr = CStr(dateCreated)
          End If
        End If
       End If
      End If
    End If

    SplitPath OutputFilename, , , , , Ext

    Set isf = New clsInfoSpoolFile
    isf.ReadInfoFile InfoSpoolFileName
    With PDFDocInfo
     If Len(Trim$(Options.StandardTitle)) > 0 Then
       .Author = GetSubstFilename(InfoSpoolFileName, RemoveLeadingAndTrailingQuotes(Trim$(Options.StandardTitle)), , , True)
      Else
       .Author = GetSubstFilename(InfoSpoolFileName, Options.SaveFilename, , , True)
     End If
     If Options.UseStandardAuthor = 1 Then
       .Creator = GetSubstFilename(InfoSpoolFileName, RemoveLeadingAndTrailingQuotes(Trim$(Options.StandardAuthor)), True, , True)
      Else
       If IsPostscriptFile(isf.FirstSpoolFileName) Then
         .Creator = GetDocUsernameFromPostScriptFile(isf.FirstSpoolFileName, False)
        Else
         .Creator = isf.FirstUserName
       End If
     End If
     If Len(Trim$(Options.StandardKeywords)) > 0 Then
      .Keywords = GetSubstFilename(InfoSpoolFileName, RemoveLeadingAndTrailingQuotes(Trim$(Options.StandardKeywords)), , , True)
     End If
     If Len(Trim$(Options.StandardSubject)) > 0 Then
      .Subject = GetSubstFilename(InfoSpoolFileName, RemoveLeadingAndTrailingQuotes(Trim$(Options.StandardSubject)), , , True)
     End If

     .CreationDate = GetDocDate(Options.StandardCreationdate, Options.StandardDateformat, dateStr)
     .ModifyDate = GetDocDate(Options.StandardModifydate, Options.StandardDateformat, dateStr)
     .Creator = App.EXEName & " Version " & App.Major & "." & App.Minor & "." & App.Revision
    End With

    PDFDocInfoFile = CreatePDFDocInfoFile(InfoSpoolFileName, PDFDocInfo)
    StampFile = CreateStampFile(InfoSpoolFileName)
    If Options.PDFPageLayout > 0 Or Options.PDFPageMode > 0 Or Options.PDFStartPage > 1 Then
     PDFDocViewFile = CreatePDFDocViewFile(InfoSpoolFileName, Options.PDFPageLayout, Options.PDFPageMode, Options.PDFStartPage)
    End If

    Select Case UCase$(Ext)
          Case "PDF"
      Select Case UCase(SubFormat)
            Case "PDF/A-1B"
        CallGScript InfoSpoolFileName, OutputFilename, Options, PDFAWriter, PDFDocInfoFile, StampFile, PDFDocViewFile, PDFA1b
       Case "PDF/A-2B"
        CallGScript InfoSpoolFileName, OutputFilename, Options, PDFAWriter, PDFDocInfoFile, StampFile, PDFDocViewFile, PDFA2b
       Case "PDF/X"
        CallGScript InfoSpoolFileName, OutputFilename, Options, PDFXWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
       Case Else
        CallGScript InfoSpoolFileName, OutputFilename, Options, PDFWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
      End Select
     Case "PNG"
      CallGScript InfoSpoolFileName, OutputFilename, Options, PNGWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
     Case "JPG"
      CallGScript InfoSpoolFileName, OutputFilename, Options, JPEGWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
     Case "BMP"
51330      CallGScript InfoSpoolFileName, OutputFilename, Options, BMPWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51340     Case "PCX"
51350      CallGScript InfoSpoolFileName, OutputFilename, Options, PCXWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51360     Case "TIF"
51370      CallGScript InfoSpoolFileName, OutputFilename, Options, TIFFWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51380     Case "PS"
51390      CallGScript InfoSpoolFileName, OutputFilename, Options, PSWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51400     Case "EPS"
51410      CallGScript InfoSpoolFileName, OutputFilename, Options, EPSWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51420     Case "TXT"
51430      CallGScript InfoSpoolFileName, OutputFilename, Options, TXTWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51440     Case "PCL"
51450      CallGScript InfoSpoolFileName, OutputFilename, Options, PCLWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51460     Case "PSD"
51470      CallGScript InfoSpoolFileName, OutputFilename, Options, PSDWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51480     Case "RAW"
51490      CallGScript InfoSpoolFileName, OutputFilename, Options, RAWWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51500     Case "SVG"
51510      CallGScript InfoSpoolFileName, OutputFilename, Options, SVGWriter, PDFDocInfoFile, StampFile, PDFDocViewFile
51520    End Select
51530
51540    KillFile InfoSpoolFileName
51550    KillFile PDFDocInfoFile
51560    KillFile StampFile
51570
51580    ConvertedOutputFilename = OutputFilename
51590    ReadyConverting = True
51600    Exit Sub
51610   Else
51620    If FileExists(InputFilename) = True Then
51630     If IsPostscriptFile(InputFilename) = True Then
51640       IFIsPS = True
51650      Else
51660       MsgBox LanguageStrings.MessagesMsg06 & vbCrLf & vbCrLf & InputFilename
51670     End If
51680    End If
51690  End If
51700  DoEvents
End;

var Options: TOptions;

begin
  try
    FillChar(Options,SizeOf(Options),#0);
    CallGScript('G:\garbage\описание проблемы.docx', 'G:\garbage\описание проблемы.pdf', Options,
                Options.AutosaveFormat, PDFDocInfoFile, StampFile,
                PDFDocViewFile);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
