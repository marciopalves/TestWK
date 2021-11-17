unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    CadastrarPedido1: TMenuItem;
    N1: TMenuItem;
    CarregarBanco1: TMenuItem;
    procedure CarregarBanco1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.CarregarBanco1Click(Sender: TObject);
begin
//
end;

end.
