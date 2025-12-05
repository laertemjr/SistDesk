program SistDesk;

uses
  Vcl.Forms,
  uCadCli in 'uCadCli.pas' {frmCadCli},
  uCadUsers in 'uCadUsers.pas' {frmCadUsers},
  uLogin in 'uLogin.pas' {frmLogin},
  uMainMenu in 'uMainMenu.pas' {frmMainMenu},
  uDM in 'uDM.pas' {dm: TDataModule},
  uGlobal in 'uGlobal.pas',
  uAbout in 'uAbout.pas' {frmAboutBox};

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
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmCadUsers, frmCadUsers);
  Application.CreateForm(TfrmCadCli, frmCadCli);
  Application.CreateForm(TfrmAboutBox, frmAboutBox);
  Application.Run;
end.
