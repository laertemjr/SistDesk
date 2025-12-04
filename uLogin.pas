unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Phys, Data.DB, System.IniFiles;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EdtUser: TEdit;
    btnLogin: TButton;
    edtSenha: TEdit;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iniconf : TIniFile;
    function conectar():Boolean;
    procedure localizarBD();
  public
    { Public declarations }
    user:string;
  end;

// Criação do registro de Usuários
TDadosUsuario = record
  usr_id:Integer;
  nome_usuario:String;
  nivel_acesso:Integer;
  credencial:String;
  id_session:Integer;
  acesso1:Boolean;
  acesso2:Boolean;
  acesso3:Boolean;
  acesso4:Boolean;
  acesso5:Boolean;
  acesso6:Boolean;
  estilo:string;
end;

var
  frmLogin: TfrmLogin;
  DadosUsuario:TDadosUsuario;
  tentativas:Integer;

implementation

uses
   uMainMenu, uDM, uGlobal;

{$R *.dfm}
// Copyright © 2025 Mancuso Software (laertemjr@outlook.com.br)


procedure TfrmLogin.FormCreate(Sender: TObject);
var hMutex : Integer;
begin
  hMutex := CreateMutex(0, TRUE, 'GlobalMutex');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
      beep;
      ShowMessage('Já existe uma instância do programa em execução.');
      Application.Terminate;
  end;
  KeyPreview := True;
  tentativas := 0;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
   while not conectar() do;
   dm.TbUsers.Close;
   dm.TbUsers.SQL.Clear;
   dm.TbUsers.SQL.Add('SELECT * FROM TB_USERS');
   dm.TbUsers.Open;
   dm.TbUsers.Last;
   EdtUser.SetFocus;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      SelectNext(ActiveControl as TWinControl, True, True);
      Key := #0;
   end;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
   if dm.TbUsers.Locate('USER_NAME;USER_PASSWORD', VarArrayOf([EdtUser.Text, edtSenha.Text]),[]) then
   begin
      user := EdtUser.Text;
      dm.TbUsers.Close;
      Self.WindowState := wsMinimized;
      Self.Visible := False;
      frmMainMenu.ShowModal;
      EdtUser.Text := EmptyStr;
      edtSenha.Text := EmptyStr;
      Self.Visible := True;
      Self.WindowState := wsNormal;
      ModalResult := mrOk;
   end
   else
   begin
      inc(tentativas); // tentativas := tentativas + 1
      if tentativas < 3 Then
        begin
          MsgAtencao('Login e/ou Senha incorretos, tentativas restantes: ' + IntToStr(3-tentativas));
          //edtLogin.Text := EmptyStr;
          //edtSenha.Text := EmptyStr;
          if EdtUser.CanFocus Then EdtUser.SetFocus;
        end
      else
        begin
          MsgAtencao('Login e/ou Senha incorretos, acesso ao sistema negado.');
          Application.Terminate;
        end;
   end;
end;

function TfrmLogin.conectar():Boolean;
begin
   dm.FDConnection1.Params.Clear;
   dm.FDConnection1.DriverName := 'MSAcc';

   if FileExists(ExtractFilePath(Application.ExeName) + 'config.ini') then
   begin
      iniconf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
      dm.FDConnection1.Params.Add('database=' + iniconf.ReadString('MSAccess', 'Path', ''));
      iniconf.Free;
   end
   else
   begin
      ShowMessage('Arquivo config.ini não localizado.');
      localizarBD();
   end;

   try
      dm.FDConnection1.Connected := True;
      Result := True;
   except
      ShowMessage('Não foi possível a conexão com o banco de dados.');
      if MsgPergunta('Revisar a localização do banco de dados ?', True) then
      begin
         localizarBD;
         Result := False;
      end
      else
      begin
         Application.Terminate;
         Abort;
      end;
   end;
end;

procedure TfrmLogin.localizarBD();
begin
   OpenDialog1.FileName := EmptyStr;
   OpenDialog1.Filter := 'Microsoft Access database|*.mdb;*.accdb';
   OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
   OpenDialog1.Title := 'Localize o Banco de Dados MS-Access';

   if OpenDialog1.Execute then
   begin
      iniconf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
      iniconf.WriteString('MSAccess', 'Path', OpenDialog1.FileName);
      dm.FDConnection1.Params.Add('database=' + OpenDialog1.FileName);
      iniconf.Free;
   end
   else
   begin
      Application.Terminate;
      Abort;
   end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if dm.FDConnection1.Connected then
      dm.FDConnection1.Connected := False;;
end;

end.
