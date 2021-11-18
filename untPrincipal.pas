unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    CadastrarPedido1: TMenuItem;
    N1: TMenuItem;
    CarregarBanco1: TMenuItem;
    Image1: TImage;
    procedure CarregarBanco1Click(Sender: TObject);
    procedure CadastrarPedido1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uDmConexao, uFrmCadPedidoView;

procedure TfrmPrincipal.CadastrarPedido1Click(Sender: TObject);
begin
  if frmCadPedido = nil then
    Application.CreateForm(TfrmCadPedido, frmCadPedido);
  frmCadPedido.ShowModal;
end;

procedure TfrmPrincipal.CarregarBanco1Click(Sender: TObject);
begin
  if DMConexao.GerarDadosIniciais then
    ShowMessage('Dados Iniciais gerados com sucesso!');

  raise Exception.Create('Error Message');
end;

end.
