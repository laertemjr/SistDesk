unit uMainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,


  FireDAC.Phys,
  Data.DB;

type
  TfrmMainMenu = class(TForm)
    btnCadCli: TBitBtn;
    btnUsers: TBitBtn;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    procedure btnCadCliClick(Sender: TObject);
    procedure btnUsersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

uses
   uCadCli, uCadUsers, uLogin, uGlobal, uAbout;

{$R *.dfm}
// Copyright © 2025 Mancuso Software (laertemjr@outlook.com.br)

procedure TfrmMainMenu.FormShow(Sender: TObject);
begin
   if DadosUsuario.credencial = 'ADM' then
      btnUsers.Enabled := True
   else
      btnUsers.Enabled := False;

   StatusBar1.Panels[0].Text := 'Usuário: ' + DadosUsuario.nome_usuario;
   StatusBar1.Panels[1].Text := 'Credencial: ' + DadosUsuario.credencial;
   //sVerInfo := GetVersionInfo(Application.ExeName);
   //StatusBar1.Panels[0].Text := '   Versão ' + sVerInfo + ' (2025) Delphi 12.1';
end;

procedure TfrmMainMenu.BitBtn1Click(Sender: TObject);
begin
   frmAboutBox.ShowModal;
end;

procedure TfrmMainMenu.btnCadCliClick(Sender: TObject);
begin
   Self.Hide;
   frmCadCli.ShowModal;
   Self.Show;
end;

procedure TfrmMainMenu.btnUsersClick(Sender: TObject);
begin
   Self.Hide;
   frmCadUsers.ShowModal;
   Self.Show;
end;

end.
