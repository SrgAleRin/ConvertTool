program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  CustomTypes in 'CustomTypes.pas';

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
  GSInit Options

  Select Case Ghostscriptdevice
        Case 0: 'PDF
    With Options
     If .PDFOptimize = 1 And .PDFUseSecurity = 0 Then
       Set Ghostscript = GetGhostscriptVersion
       If ((Ghostscript.VersionMajor < 9) Or (Ghostscript.VersionMajor = 9 And Ghostscript.VersionMinor < 7)) Then
        Tempfile = GetTempFile(GetTempPathApi, "~CP")
         KillFile Tempfile
        CreatePDF GSInfoSpoolFile, Tempfile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile
         OptimizePDF Tempfile, GSOutputFile
         KillFile Tempfile
        Else
         CreatePDF GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile
      End If
      Else
      If .PDFUseSecurity <> 0 And SecurityIsPossible = True Then
         If pdfforgeDllInstalled And .PDFAes128Encryption = 1 Then
           enc = SetEncryptionParams(encPDF, GSInfoSpoolFile, GSOutputFile)
          If enc = True Then
             Tempfile = GetTempFile(GetTempPathApi, "~CP")
             KillFile Tempfile
             currentOwnerPassword = encPDF.OwnerPass
             currentUserPassword = encPDF.UserPass
             CreatePDF GSInfoSpoolFile, Tempfile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile
             encPDF.InputFile = Tempfile
             retEnc = EncryptPDFUsingPdfforgeDll(encPDF)
            If retEnc = False Then
              IfLoggingWriteLogfile "Error with encryption - using unencrypted file"
              KillFile GSOutputFile
             If FileExists(GSOutputFile) = False Then
              Name Tempfile As GSOutputFile
              End If
            End If
          Else
             If Options.UseAutosave = 0 Then
              MsgBox LanguageStrings.MessagesMsg23, vbCritical
             End If
            CreatePDF GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile
           End If
          Else
           tL = .PDFOptimize
           .PDFOptimize = 0
           CreatePDF GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile
           .PDFOptimize = tL
        End If
        Else
        CreatePDF GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile
       End If
     End If
     If pdfforgeDllInstalled Then
      If .PDFUpdateMetadata > 0 Then
      If .PDFUpdateMetadata = 2 Or _
       (.PDFUpdateMetadata = 1 And (InStr(1, .AdditionalGhostscriptParameters, "dpdfa", vbTextCompare) > 0)) Then
       Set m = CreateObject("pdfForge.pdf.pdf")
        Tempfile = GetTempFile(GetTempPathApi, "~MP")
        KillFile Tempfile
        Call m.UpdateXMPMetadata(GSOutputFile, Tempfile)
        If FileExists(Tempfile) Then
         If KillFile(GSOutputFile) Then
          Name Tempfile As GSOutputFile
         End If
        End If
       End If
      End If
     End If
     If DotNet20Installed And pdfforgeDllInstalled Then
      If .PDFSigningSignPDF = 1 Then
       SignPDF GSOutputFile, currentOwnerPassword, currentUserPassword
      End If
     End If
    End With
   Case 1: 'PNG
    CreatePNG GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 2: 'JPEG
    CreateJPEG GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 3: 'BMP
    CreateBMP GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 4: 'PCX
    CreatePCX GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 5: 'TIFF
    CreateTIFF GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 6: 'PS
    CreatePS GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 7: 'EPS
    CreateEPS GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 8: 'TXT
    CreateTXT GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
    CreateTextFile GSOutputFile, GS_OutStr
   Case 9: 'PDFA
    CreatePDFA GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile, PDFAFormat
    With Options
     If DotNet20Installed And pdfforgeDllInstalled Then
      If .PDFUpdateMetadata > 0 Then
       Set m = CreateObject("pdfForge.pdf.pdf")
       Tempfile = GetTempFile(GetTempPathApi, "~MP")
       KillFile Tempfile
       Call m.UpdateXMPMetadata(GSOutputFile, Tempfile)
       If FileExists(Tempfile) Then
        If KillFile(GSOutputFile) Then
         Name Tempfile As GSOutputFile
        End If
       End If
      End If
      If .PDFSigningSignPDF = 1 Then
       SignPDF GSOutputFile
      End If
     End If
    End With
   Case 10: 'PDFX
    CreatePDFX GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile, PDFDocViewFile
    With Options
     If DotNet20Installed And pdfforgeDllInstalled Then
      If .PDFSigningSignPDF = 1 Then
       SignPDF GSOutputFile
      End If
     End If
    End With
   Case 11: 'PSD
    CreatePSD GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 12: 'PCL
    CreatePCL GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 13: 'RAW
    CreateRAW GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
   Case 14: 'SVG
    CreateSVG GSInfoSpoolFile, GSOutputFile, Options, PDFDocInfoFile, StampFile
  End Select

Exit Function
ErrPtnr_OnError:
Select Case ErrPtnr.OnError("modGhostScript", "CallGScript")
Case 0: Resume
Case 1: Resume Next
Case 2: Exit Function
Case 3: End
End Select
End;

begin
  try
    CallGScript spoolFile.FullFileName, OutputFilename, Options, Options.AutosaveFormat, PDFDocInfoFile, StampFile, PDFDocViewFile
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
