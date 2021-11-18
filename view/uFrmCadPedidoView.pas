unit uFrmCadPedidoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids,   Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uPedidoControl;

type
  TfrmCadPedido = class(TForm)
    pnlTop: TPanel;
    edtNumeroPesq: TEdit;
    Label1: TLabel;
    btnPesqPedido: TButton;
    PageControl1: TPageControl;
    tsPesquisa: TTabSheet;
    tsPedido: TTabSheet;
    grdPedidos: TDBGrid;
    pnlBotoes: TPanel;
    btnIncluir: TButton;
    btnAlterar: TButton;
    Button2: TButton;
    qryPedido: TFDQuery;
    qryPedidoNumero: TIntegerField;
    qryPedidoIdPedido: TIntegerField;
    qryPedidoCODCLI: TIntegerField;
    qryPedidoDTCADASTRO: TDateField;
    qryPedidoCliente: TStringField;
    dsPedido: TDataSource;
    qryPedidoTOTAL: TFloatField;
    pnlItens: TPanel;
    pnlCabecalhoPedido: TPanel;
    lblNumero: TLabel;
    Label2: TLabel;
    lblDtCadastro: TLabel;
    Label3: TLabel;
    edtNumero: TEdit;
    edtCodCli: TEdit;
    edtCliente: TEdit;
    DateTimePicker1: TDateTimePicker;
    edtTotal: TEdit;
    pnlIncusaoItens: TPanel;
    btnInserirItem: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    pnlRodape: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure edtNumeroPesqKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesqPedidoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Exit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    vPedidoControl: TPedidoControl;
    Procedure LimparCampos;
  public
    { Public declarations }
  end;

var
  frmCadPedido: TfrmCadPedido;

implementation

{$R *.dfm}

uses uDmConexao;

procedure TfrmCadPedido.btnConfirmarClick(Sender: TObject);
begin
  vPedidoControl.Salvar;
end;

procedure TfrmCadPedido.btnIncluirClick(Sender: TObject);
begin
  LimparCampos;
  edtNumero.Text := IntToStr(vPedidoControl.ProximoNumero);
end;

procedure TfrmCadPedido.btnPesqPedidoClick(Sender: TObject);
Var
  vQry: TFDQuery;
begin
  if StrToIntDef(edtNumeroPesq.Text, 0) > 0 then
  begin
    try
      vQry := vPedidoControl.BuscarPedido(StrToInt(edtNumeroPesq.Text));
      qryPedido.Close;
      qryPedido.Data := vQry.Data;
    finally
      FreeAndNil(vQry);
    end;
  end
  else
  begin
    edtNumeroPesq.SetFocus;
    raise Exception.Create('É necessario informar um numero maior que zero para a pesquisa!');
  end;
end;

procedure TfrmCadPedido.Button2Click(Sender: TObject);
begin
  if (Application.MessageBox(PChar('Deseja realmente excluir o registro!'),
      'Confirmação', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)= mrYes) then
  begin
    vPedidoControl.ExcluirPedido(qryPedidoNumero.AsInteger);
  end;
end;

procedure TfrmCadPedido.Edit1Exit(Sender: TObject);
begin
  if StrToIntDef(edtCodCli.Text, 0)> 0 then
  begin
    //Pesquisar Produto e setar campos
  end;
end;

procedure TfrmCadPedido.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if Not (key in ['0'..'9', #08]) then
    key := #0;
end;

procedure TfrmCadPedido.edtCodCliExit(Sender: TObject);
begin
  if StrToIntDef(edtCodCli.Text, 0)> 0 then
  begin
    //Pesquisar Cliente e setar campos
  end;
end;

procedure TfrmCadPedido.edtNumeroPesqKeyPress(Sender: TObject; var Key: Char);
begin
  if Not (key in ['0'..'9', #08]) then
    key := #0;
end;

procedure TfrmCadPedido.LimparCampos;
Var
  vCont:Integer;
begin
  for vCont := 0 to frmCadPedido.ComponentCount -1 do
  begin
    if frmCadPedido.Components[vCont] is TEdit then
      TEdit(frmCadPedido.Components[vCont]).clear;
  end;
end;

end.
