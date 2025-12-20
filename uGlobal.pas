unit uGlobal;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms, System.Win.Registry, System.Classes;

procedure CriarFormulario(T:TFormClass;F:TForm);
function GetVersionInfo(const app:string):string;
procedure MsgAtencao(pMsg:String);
procedure MsgInformacao(pMsg:String);
procedure MsgErro(pMsg:String);
function MsgPergunta(pMsg:String; pFocoBotaoSim:Boolean=True):Boolean;
function GetComputerNameFunc: string;
procedure LeituraEstilos;
procedure EstiloPadrao;

var
   sVerInfo : string;
   bAbortar : Boolean;
   valueNames : TStringList;
   function PCName:string;

implementation

uses uLogin, uDM, uMainMenu, Vcl.Themes;

procedure CriarFormulario(T:TFormClass;F:TForm);
// Exemplo de chamada: CriarFormulario(TfrmCadastro, frmCadastro);
begin
   Screen.ActiveForm.WindowState := TWindowState.wsMinimized;
   try
      try
         Application.CreateForm(T,F);
         F.Position := poScreenCenter;
         F.ShowModal;
     except
        MsgErro('Erro na criação do formulário.');
     end;
   finally
     try
        //F.Free;
        FreeAndNil(F);
     except
        MsgErro('Erro na liberação do formulário.');
     end;
   end;
   frmMainMenu.WindowState := TWindowState.wsNormal;
end;

function GetVersionInfo(const app:string):string;
type
  TVersionInfo = packed record
    Dummy: array[0..7] of Byte;
    V2, V1, V4, V3: Word;
  end;
var
  Zero, Size: Cardinal;
  Data: Pointer;
  VersionInfo: ^TVersionInfo;
begin
  Size := GetFileVersionInfoSize(Pointer(app), Zero);
  if Size = 0 then
    Result := ''
  else
  begin
    GetMem(Data, Size);
    try
      GetFileVersionInfo(Pointer(app), 0, Size, Data);
      VerQueryValue(Data, '\', Pointer(VersionInfo), Size);
      Result := VersionInfo.V1.ToString + '.' + VersionInfo.V2.ToString + '.' + VersionInfo.V3.ToString + '.' + VersionInfo.V4.ToString;
    finally
      FreeMem(Data);
    end;
  end;
end;

procedure MsgAtencao(pMsg:String);
begin
  Application.MessageBox(PChar(pMsg), 'Atenção!', MB_ICONWARNING + MB_OK);
end;

procedure MsgInformacao(pMsg:String);
begin
  Application.MessageBox(PChar(pMsg), 'Informação:', MB_ICONINFORMATION + MB_OK);
end;

function MsgPergunta(pMsg:String; pFocoBotaoSim:Boolean=True):Boolean;
begin
   if pFocoBotaoSim then
   begin
      Result := Application.MessageBox(PChar(pMsg), 'Informar:', MB_ICONQUESTION + MB_YESNO) = IDYES;
   end
   else
   begin
      Result := Application.MessageBox(PChar(pMsg), 'Informar:', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = IDYES;
   end;
end;

procedure MsgErro(pMsg:String);
begin
  Application.MessageBox(PChar(pMsg), 'Erro:', MB_ICONERROR + MB_OK);
end;

function GetComputerNameFunc: string;
var ipbuffer : string;
      nsize : dword;
begin
   nsize := 255;
   SetLength(ipbuffer,nsize);
   if GetComputerName(pchar(ipbuffer),nsize) then
      result := ipbuffer;
end;

procedure LeituraEstilos;
begin{
   try
      TStyleManager.SetStyle(GetValorIni(vFileName, 'ESTILO', 'APLICADO'));
   except
      EstiloPadrao;
   end;}
   try
      TStyleManager.SetStyle(DadosUsuario.estilo);
   except
      EstiloPadrao;
   end;
   {if TStyleManager.ActiveStyle.Name = 'Windows' then
      frmMenuPrincipal.Estilopadro1.Checked := True
   else
      frmMenuPrincipal.Estilopadro1.Checked := False;}
end;

procedure EstiloPadrao;
begin
   TStyleManager.TrySetStyle('Windows');
   DadosUsuario.estilo := 'Windows';
   dm.TbUsers.Open();
   dm.TbUsers.Locate('USER_ID', DadosUsuario.usr_id);
   dm.TbUsers.Edit;
   dm.TbUsers.FieldByName('USER_STYLE').Value := 'Windows';
   dm.TbUsers.Post;
   dm.TbUsers.Close;
end;

function PCName:string;
var
   lSize:Cardinal;
   lComputerName: array [0..MAX_PATH] of Char;
begin
   lSize := MAX_PATH;
   GetComputerName(lComputerName, lSize);
   Result := lComputerName;
end;

end.
