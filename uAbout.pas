unit uAbout;

interface

uses WinApi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutBox: TfrmAboutBox;

implementation

uses uGlobal;

{$R *.dfm}

procedure TfrmAboutBox.FormCreate(Sender: TObject);
begin
   sVerInfo := GetVersionInfo(Application.ExeName);
   Version.Caption := 'Version ' + sVerInfo + ' (Delphi 12.1 Athens)';
   Copyright.Caption := 'Copyright © 2025 Mancuso Software';
   Comments.Caption := 'laertemjr@outlook.com.br';
end;

end.
 
