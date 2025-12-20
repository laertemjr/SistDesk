unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Phys, Data.DB, System.IniFiles,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnLogin: TButton;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    lblEdtLogin: TLabeledEdit;
    lblEdtSenha: TLabeledEdit;
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
  end;

var
  frmLogin: TfrmLogin;
  tentativas:Integer;

implementation

uses
   uMainMenu, uDM, uGlobal;

{$R *.dfm}
// Copyright © 2025 Mancuso Software (laertemjr@outlook.com.br)


procedure TfrmLogin.FormCreate(Sender: TObject);
var hMutex : Integer;
begin

  tentativas := 0;

  hMutex := CreateMutex(0, TRUE, 'GlobalMutex');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
      beep;
      ShowMessage('O programa já está em execução.');
      Application.Terminate;
  end;
  KeyPreview := True;

end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
   while not conectar() do;
   dm.TbUsers.Close;
   dm.TbUsers.SQL.Clear;
   dm.TbUsers.SQL.Add('SELECT * FROM TB_USERS');
   dm.TbUsers.Open;
   dm.TbUsers.Last;
   lblEdtLogin.SetFocus;
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
   if dm.TbUsers.Locate('USER_LOGIN;USER_PASSWORD', VarArrayOf([lblEdtLogin.Text, lblEdtSenha.Text]),[]) then
   begin
     if (dm.TbUsers.FieldByName('USER_PC_RESTRICTED').AsBoolean) and (dm.TbUsers.FieldByName('USER_PC_NAME').AsString <> Emptystr) then
     begin
       if dm.TbUsers.FieldByName('USER_PC_NAME').AsString <> PCName then
       begin
          MsgAtencao('Acesso ao usuário negado neste computador.');
          ModalResult := mrCancel;
          Exit;
       end;
     end;
      DadosUsuario.usr_id       := dm.TbUsers.FieldByName('USER_ID').AsInteger;
      DadosUsuario.nome_usuario := dm.TbUsers.FieldByName('USER_NAME').AsString;
      DadosUsuario.login_usr    := dm.TbUsers.FieldByName('USER_LOGIN').AsString;
      DadosUsuario.credencial   := dm.TbUsers.FieldByName('USER_CREDENTIAL').AsString;
      DadosUsuario.nivel_acesso := dm.TbUsers.FieldByName('USER_CLEARANCE').AsInteger;
      DadosUsuario.estilo       := dm.TbUsers.FieldByName('USER_STYLE').AsString;
      MsgInformacao('Seja bem-vindo(a) ' + DadosUsuario.nome_usuario + ' !');
      dm.TbUsers.Close;
      ModalResult := mrOk;
   end
   else
   begin
      inc(tentativas); // tentativas := tentativas + 1
      if tentativas < 3 Then
        begin
          MsgAtencao('Login e/ou Senha incorretos, tentativas restantes: ' + IntToStr(3-tentativas));
          //edtLogin.Text := EmptyStr;
          lblEdtSenha.Text := EmptyStr;
          lblEdtLogin.SetFocus;
          lblEdtLogin.SelLength := 0;
          lblEdtLogin.SelStart := Length(lblEdtLogin.Text);
        end
      else
        begin
          MsgAtencao('Login e/ou Senha incorretos, acesso ao sistema negado.');
          ModalResult := mrCancel;
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
