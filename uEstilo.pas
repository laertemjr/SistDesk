unit uEstilo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.StrUtils, FireDAC.Comp.Client,
  Vcl.ComCtrls;

type
  TfrmEstilos = class(TForm)
    Label5: TLabel;
    ComboBox1: TComboBox;
    btnEstiloPadrao1: TButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEstiloPadrao1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaEstilos;
  end;

var
  frmEstilos: TfrmEstilos;

implementation

uses
   uDM, uMainMenu, Vcl.Themes, Vcl.Styles, System.IniFiles, uGlobal;

{$R *.dfm}

procedure TfrmEstilos.FormShow(Sender: TObject);
begin
   CarregaEstilos;
   if DadosUsuario.estilo = 'Windows' then btnEstiloPadrao1.Enabled := False
      else btnEstiloPadrao1.Enabled := True;
end;

procedure TfrmEstilos.btnEstiloPadrao1Click(Sender: TObject);
begin
   EstiloPadrao;
   btnEstiloPadrao1.Enabled := False;
end;

procedure TfrmEstilos.CarregaEstilos;
var s: String;
begin
   ComboBox1.Items.BeginUpdate;
   try
      ComboBox1.Items.Clear;
      for s in TStyleManager.StyleNames do ComboBox1.Items.Add(s);
      ComboBox1.Sorted := True;
      // Select the style that's currently in use in the combobox
      ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(TStyleManager.ActiveStyle.Name);
   finally
      ComboBox1.Items.EndUpdate;
   end;
end;

procedure TfrmEstilos.ComboBox1Change(Sender: TObject);
var sNovoEstilo :string;
begin
   sNovoEstilo := ComboBox1.Items[ComboBox1.ItemIndex];
   TStyleManager.TrySetStyle(sNovoEstilo);
   DadosUsuario.estilo := sNovoEstilo;
   dm.TbUsers.Open();
   dm.TbUsers.Locate('USER_ID', DadosUsuario.usr_id);
   dm.TbUsers.Edit;
   dm.TbUsers.FieldByName('USER_STYLE').Value := sNovoEstilo;
   dm.TbUsers.Post;
   dm.TbUsers.Close;
end;

end.
