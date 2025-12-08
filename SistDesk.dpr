program SistDesk;

uses
  Vcl.Forms,
  Vcl.Controls,
  System.SysUtils,
  Vcl.Themes,
  Vcl.Styles,
  uCadCli in 'uCadCli.pas' {frmCadCli},
  uCadUsers in 'uCadUsers.pas' {frmCadUsers},
  uLogin in 'uLogin.pas' {frmLogin},
  uMainMenu in 'uMainMenu.pas' {frmMainMenu},
  uDM in 'uDM.pas' {dm: TDataModule},
  uGlobal in 'uGlobal.pas',
  uAbout in 'uAbout.pas' {frmAboutBox},
  uEstilo in 'uEstilo.pas' {frmEstilos};

{$R *.res}

{
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDados, dmDados);
  Application.Run;
end.
}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SistDesk';
  Application.CreateForm(Tdm, dm);
  // frmLogin é criado, a propriedade visible dever ser "False", pois esta sendo criando em runtime
  with TfrmLogin.Create(nil) do
   try
      ShowModal;
      if ModalResult = mrOk then
      begin
         Application.CreateForm(TfrmMainMenu, frmMainMenu);
         frmMainMenu.StatusBar1.Panels[0].Text := 'Usuário: ' + DadosUsuario.nome_usuario;
         frmMainMenu.StatusBar1.Panels[1].Text := 'Credencial: ' + DadosUsuario.credencial;
      end
      else
         Application.Terminate;
   finally
      FreeAndNil(frmLogin); // requer usar "SysUtils"
      Application.Run;
   end;
end.
