unit CustomTypes;

interface

Type
  tOptions = record
    AdditionalGhostscriptParameters: String;
    AdditionalGhostscriptSearchpath: String;
    AddWindowsFontpath: LongInt;
    AllowSpecialGSCharsInFilenames: LongInt;
    AutosaveDirectory: String;
    AutosaveFilename: String;
    AutosaveFormat: LongInt;
    AutosaveStartStandardProgram: LongInt;
    BMPColorscount: LongInt;
    BMPResolution: LongInt;
    ClientComputerResolveIPAddress: LongInt;
    Counter: Currency;
    DeviceHeightPoints: Double;
    DeviceWidthPoints: Double;
    DirectoryGhostscriptBinaries: String;
    DirectoryGhostscriptFonts: String;
    DirectoryGhostscriptLibraries: String;
    DirectoryGhostscriptResource: String;
    DisableEmail: LongInt;
    DontUseDocumentSettings: LongInt;
    EPSLanguageLevel: LongInt;
    FilenameSubstitutions: String;
    FilenameSubstitutionsOnlyInTitle: LongInt;
    JPEGColorscount: LongInt;
    JPEGQuality: LongInt;
    JPEGResolution: LongInt;
    Language: String;
    LastSaveDirectory: String;
    Logging: LongInt;
    LogLines: LongInt;
    NoConfirmMessageSwitchingDefaultprinter: LongInt;
    NoProcessingAtStartup: LongInt;
    NoPSCheck: LongInt;
    OneFilePerPage: LongInt;
    OneFilePerPageLeadingChar: LongInt;
    OneFilePerPageMaxCountOfLeadingChars: LongInt;
    OpenOutputFile: LongInt;
    OptionsDesign: LongInt;
    OptionsEnabled: LongInt;
    OptionsVisible: LongInt;
    Papersize: String;
    PCLColorsCount: LongInt;
    PCLResolution: LongInt;
    PCXColorscount: LongInt;
    PCXResolution: LongInt;
    PDFAllowAssembly: LongInt;
    PDFAllowDegradedPrinting: LongInt;
    PDFAllowFillIn: LongInt;
    PDFAllowScreenReaders: LongInt;
    PDFColorsCMYKToRGB: LongInt;
    PDFColorsColorModel: LongInt;
    PDFColorsPreserveHalftone: LongInt;
    PDFColorsPreserveOverprint: LongInt;
    PDFColorsPreserveTransfer: LongInt;
    PDFCompressionColorCompression: LongInt;
    PDFCompressionColorCompressionChoice: LongInt;
    PDFCompressionColorCompressionJPEGHighFactor: Double;
    PDFCompressionColorCompressionJPEGLowFactor: Double;
    PDFCompressionColorCompressionJPEGMaximumFactor: Double;
    PDFCompressionColorCompressionJPEGMediumFactor: Double;
    PDFCompressionColorCompressionJPEGMinimumFactor: Double;
    PDFCompressionColorResample: LongInt;
    PDFCompressionColorResampleChoice: LongInt;
    PDFCompressionColorResolution: LongInt;
    PDFCompressionGreyCompression: LongInt;
    PDFCompressionGreyCompressionChoice: LongInt;
    PDFCompressionGreyCompressionJPEGHighFactor: Double;
    PDFCompressionGreyCompressionJPEGLowFactor: Double;
    PDFCompressionGreyCompressionJPEGMaximumFactor: Double;
    PDFCompressionGreyCompressionJPEGMediumFactor: Double;
    PDFCompressionGreyCompressionJPEGMinimumFactor: Double;
    PDFCompressionGreyResample: LongInt;
    PDFCompressionGreyResampleChoice: LongInt;
    PDFCompressionGreyResolution: LongInt;
    PDFCompressionMonoCompression: LongInt;
    PDFCompressionMonoCompressionChoice: LongInt;
    PDFCompressionMonoResample: LongInt;
    PDFCompressionMonoResampleChoice: LongInt;
    PDFCompressionMonoResolution: LongInt;
    PDFCompressionTextCompression: LongInt;
    PDFDisallowCopy: LongInt;
    PDFDisallowModifyAnnotations: LongInt;
    PDFDisallowModifyContents: LongInt;
    PDFDisallowPrinting: LongInt;
    PDFEncryptor: LongInt;
    PDFFontsEmbedAll: LongInt;
    PDFFontsSubSetFonts: LongInt;
    PDFFontsSubSetFontsPercent: LongInt;
    PDFGeneralASCII85: LongInt;
    PDFGeneralAutorotate: LongInt;
    PDFGeneralCompatibility: LongInt;
    PDFGeneralDefault: LongInt;
    PDFGeneralOverprint: LongInt;
    PDFGeneralResolution: LongInt;
    PDFHighEncryption: LongInt;
    PDFLowEncryption: LongInt;
    PDFOptimize: LongInt;
    PDFOwnerPass: LongInt;
    PDFOwnerPasswordString: String;
    PDFSigningMultiSignature: LongInt;
    PDFSigningPFXFile: String;
    PDFSigningPFXFilePassword: String;
    PDFSigningSignatureContact: String;
    PDFSigningSignatureLeftX: Double;
    PDFSigningSignatureLeftY: Double;
    PDFSigningSignatureLocation: String;
    PDFSigningSignatureReason: String;
    PDFSigningSignatureRightX: Double;
    PDFSigningSignatureRightY: Double;
    PDFSigningSignatureVisible: LongInt;
    PDFSigningSignPDF: LongInt;
    PDFUpdateMetadata: LongInt;
    PDFUserPass: LongInt;
    PDFUserPasswordString: String;
    PDFUseSecurity: LongInt;
    PNGColorscount: LongInt;
    PNGResolution: LongInt;
    PrintAfterSaving: LongInt;
    PrintAfterSavingDuplex: LongInt;
    PrintAfterSavingNoCancel: LongInt;
    PrintAfterSavingPrinter: String;
    PrintAfterSavingQueryUser: LongInt;
    PrintAfterSavingTumble: LongInt;
    PrinterStop: LongInt;
    PrinterTemppath: String;
    ProcessPriority: LongInt;
    ProgramFont: String;
    ProgramFontCharset: LongInt;
    ProgramFontSize: LongInt;
    PSDColorsCount: LongInt;
    PSDResolution: LongInt;
    PSLanguageLevel: LongInt;
    RAWColorsCount: LongInt;
    RAWResolution: LongInt;
    RemoveAllKnownFileExtensions: LongInt;
    RemoveSpaces: LongInt;
    RunProgramAfterSaving: LongInt;
    RunProgramAfterSavingProgramname: String;
    RunProgramAfterSavingProgramParameters: String;
    RunProgramAfterSavingWaitUntilReady: LongInt;
    RunProgramAfterSavingWindowstyle: LongInt;
    RunProgramBeforeSaving: LongInt;
    RunProgramBeforeSavingProgramname: String;
    RunProgramBeforeSavingProgramParameters: String;
    RunProgramBeforeSavingWindowstyle: LongInt;
    SaveFilename: String;
    SendEmailAfterAutoSaving: LongInt;
    SendMailMethod: LongInt;
    ShowAnimation: LongInt;
    StampFontColor: String;
    StampFontname: String;
    StampFontsize: LongInt;
    StampOutlineFontthickness: LongInt;
    StampString: String;
    StampUseOutlineFont: LongInt;
    StandardAuthor: String;
    StandardCreationdate: String;
    StandardDateformat: String;
    StandardKeywords: String;
    StandardMailDomain: String;
    StandardModifydate: String;
    StandardSaveformat: LongInt;
    StandardSubject: String;
    StandardTitle: String;
    StartStandardProgram: LongInt;
    TIFFColorscount: LongInt;
    TIFFResolution: LongInt;
    Toolbars: LongInt;
    UseAutosave: LongInt;
    UseAutosaveDirectory: LongInt;
    UseCreationDateNow: LongInt;
    UseCustomPaperSize: String;
    UseFixPapersize: LongInt;
    UseStandardAuthor: LongInt;
  End;

  EncryptionStrength = (encLow,encStrong);

  EncryptData = record
    InputFile: String;
    OutputFile: String;
    UserPass: String;
    OwnerPass: String;
    DisallowPrinting: Boolean;
    DisallowModifyContents: Boolean;
    DisallowCopy: Boolean;
    DisallowModifyAnnotations: Boolean;
    AllowFillIn: Boolean;
    AllowScreenReaders: Boolean;
    AllowAssembly: Boolean;
    AllowDegradedPrinting: Boolean;
    EncryptionLevel: EncryptionStrength;
  End;

  tGhostscriptDevice = (PDFWriter,PNGWriter,JPEGWriter,BMPWriter,PCXWriter,
                        TIFFWriter,PSWriter,EPSWriter,TXTWriter,PDFAWriter,
                        PDFXWriter,PSDWriter,PCLWriter,RAWWriter,SVGWriter);

  tPDFAFormat = (PDFA1b,PDFA2b);

  clsGhostscript = record
    VersionInternal: Boolean;
    VersionMajor: Integer;
    VersionMinor: Integer;
    Description: String;
  end;

  tGhostscriptRevision = record
    strProduct: String;
    strCopyright: String;
    intRevision: Integer;
    intRevisionDate: Integer;
  end;




var
//'General
GS_PDFDEFAULT: string;
GS_COMPATIBILITY: string;
GS_AUTOROTATE: string;
GS_OVERPRINT: string;
GS_ASCII85: string;

//'Compression
GS_COMPRESSPAGES: string;
GS_COMPRESSCOLOR: string;
GS_COMPRESSGREY: string;
GS_COMPRESSMONO: string;
GS_COMPRESSCOLORMETHOD: string;
GS_COMPRESSGREYMETHOD: string;
GS_COMPRESSMONOMETHOD: string;
GS_COMPRESSCOLORVALUE: string;
GS_COMPRESSGREYVALUE: string;
GS_COMPRESSMONOVALUE: string;
GS_COMPRESSCOLORLEVEL: string;
GS_COMPRESSGREYLEVEL: string;
GS_COMPRESSCOLORAUTO: string;
GS_COMPRESSGREYAUTO: string;
GS_COLORRESOLUTION: string;
GS_GREYRESOLUTION: string;
GS_MONORESOLUTION: string;
GS_COLORRESAMPLE: string;
GS_GREYRESAMPLE: string;
GS_MONORESAMPLE: string;
GS_COLORRESAMPLEMETHOD: string;
GS_GREYRESAMPLEMETHOD: string;
GS_MONORESAMPLEMETHOD: string;

//'Fonts
GS_EMBEDALLFONTS: string;
GS_SUBSETFONTS: string;
GS_SUBSETFONTPERC: string;
GS_KEEPFONTNAMES: string;

//'Colors
GS_COLORMODEL: string;
GS_CMYKTORGB: string;
GS_PRESERVEOVERPRINT: string;
GS_TRANSFERFUNCTIONS: string;
GS_HALFTONE: string;

//'Bitmap
GS_PNGColorscount: string;
GS_JPEGColorscount: string;
GS_BMPColorscount: string;
GS_PCXColorscount: string;
GS_TIFFColorscount: string;
GS_JPEGQuality: string;
GS_PSDColorscount: string;
GS_PCLColorscount: string;
GS_RAWColorscount: string;

//'Postscript
GS_PSLanguageLevel: string;
GS_EPSLanguageLevel: string;


GS_ERROR: Integer;
UseReturnPipe: Integer;

GSRevision: tGhostscriptRevision;

GSParams: array of string;
GSParamsIndex: Integer;



implementation

end.
