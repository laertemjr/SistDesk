unit uMainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,


  FireDAC.Phys,
  Data.DB, Vcl.Menus;

type
  TfrmMainMenu = class(TForm)
    btnCadCli: TBitBtn;
    btnUsers: TBitBtn;
    StatusBar1: TStatusBar;
    btnAbout: TBitBtn;
    btnStyle: TBitBtn;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Configuraes1: TMenuItem;
    Configuraes2: TMenuItem;
    EstiloPadro1: TMenuItem;
    Administrativo1: TMenuItem;
    Usurios1: TMenuItem;
    Sobre1: TMenuItem;
    procedure btnCadCliClick(Sender: TObject);
    procedure btnUsersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnStyleClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Configuraes2Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure EstiloPadro1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

// Criação do registro de Usuários
TDadosUsuario = record
  usr_id:Integer;
  nome_usuario:String;
  login_usr:String;
  credencial:String;
  nivel_acesso:Integer;
  estilo:string;
  {id_session:Integer;
  acesso1:Boolean;
  acesso2:Boolean;
  acesso3:Boolean;
  acesso4:Boolean;
  acesso5:Boolean;
  acesso6:Boolean;}
end;

var
  frmMainMenu: TfrmMainMenu;
  DadosUsuario:TDadosUsuario;

implementation

uses
   uCadCli, uCadUsers, uLogin, uGlobal, uAbout, uEstilo;

{$R *.dfm}
// Copyright © 2025 Mancuso Software (laertemjr@outlook.com.br)

procedure TfrmMainMenu.FormActivate(Sender: TObject);
begin
   LeituraEstilos;
end;

procedure TfrmMainMenu.FormShow(Sender: TObject);
begin
   if DadosUsuario.estilo = 'Windows' then
   begin
      EstiloPadro1.Checked := True;
      EstiloPadro1.Enabled := False;
   end
   else
   begin
      EstiloPadro1.Checked := False;
      EstiloPadro1.Enabled := True;
   end;

   if DadosUsuario.credencial = 'ADM' then
   begin
      btnUsers.Enabled := True;
      Administrativo1.Enabled := True;
   end
   else
   begin
      btnUsers.Enabled := False;
      Administrativo1.Enabled := False;
   end;

   StatusBar1.Panels[0].Text := 'Usuário: ' + DadosUsuario.nome_usuario;
   StatusBar1.Panels[1].Text := 'Credencial: ' + DadosUsuario.credencial;
   //sVerInfo := GetVersionInfo(Application.ExeName);
   //StatusBar1.Panels[0].Text := '   Versão ' + sVerInfo + ' (2025) Delphi 12.1';
end;

procedure TfrmMainMenu.Sobre1Click(Sender: TObject);
begin
   CriarFormulario(TfrmAboutBox, frmAboutBox);
end;

procedure TfrmMainMenu.Usurios1Click(Sender: TObject);
begin
   CriarFormulario(TfrmCadUsers, frmCadUsers);
end;

procedure TfrmMainMenu.btnAboutClick(Sender: TObject);
begin
   CriarFormulario(TfrmAboutBox, frmAboutBox);
end;

procedure TfrmMainMenu.btnCadCliClick(Sender: TObject);
begin
   CriarFormulario(TfrmCadCli, frmCadCli);
end;

procedure TfrmMainMenu.btnStyleClick(Sender: TObject);
begin
   CriarFormulario(TfrmEstilos, frmEstilos);
end;

procedure TfrmMainMenu.btnUsersClick(Sender: TObject);
begin
   CriarFormulario(TfrmCadUsers, frmCadUsers);
end;

procedure TfrmMainMenu.Clientes1Click(Sender: TObject);
begin
   CriarFormulario(TfrmCadCli, frmCadCli);
end;

procedure TfrmMainMenu.Configuraes2Click(Sender: TObject);
begin
   CriarFormulario(TfrmEstilos, frmEstilos);
end;

procedure TfrmMainMenu.EstiloPadro1Click(Sender: TObject);
begin
   if not EstiloPadro1.Checked then
   begin
      EstiloPadro1.Checked := True;
      EstiloPadrao;
   end;
end;

end.
