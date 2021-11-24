unit uFrmCadPedidoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids,   Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uPedidoControl,
  System.Actions, Vcl.ActnList, uFrmPesqCliente, uClienteControl,
  uProdutoControl, uItemModel, uAcaoEnum;

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
    dtpDataCad: TDateTimePicker;
    edtTotal: TEdit;
    pnlIncusaoItens: TPanel;
    btnInserirItem: TButton;
    edtCodProd: TEdit;
    edtDescricaoProduto: TEdit;
    Label4: TLabel;
    edtPreco: TEdit;
    Label5: TLabel;
    edtQtd: TEdit;
    Label6: TLabel;
    pnlRodape: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    dbgItens: TDBGrid;
    qryItens: TFDQuery;
    dsItens: TDataSource;
    qryItensIdItem: TIntegerField;
    qryItensIdPedido: TIntegerField;
    qryItensCodProd: TIntegerField;
    qryItensQtd: TFloatField;
    qryItensPreco: TFloatField;
    qryItensTotalItem: TFloatField;
    qryItensDescricao: TStringField;
    ActionList: TActionList;
    actPesquisarCliente: TAction;
    actPesquisarProduto: TAction;
    procedure edtNumeroPesqKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesqPedidoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtQtdKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure actPesquisarClienteExecute(Sender: TObject);
    procedure btnInserirItemClick(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    vPedidoControl: TPedidoControl;
    FItemModel: TItemModel;
    procedure BuscaItensPedido;
    Procedure LimparCampos;
    procedure PreencheEditsCabecalho;
    procedure TotalPedido;
    procedure CarregarPedido;

  public
    { Public declarations }
    property Item: TItemModel read FItemModel write FItemModel;
  end;

var
  frmCadPedido: TfrmCadPedido;

implementation

{$R *.dfm}

uses uDmConexao;

procedure TfrmCadPedido.actPesquisarClienteExecute(Sender: TObject);
begin
  if frmPesqClientes = nil then
    Application.CreateForm(TfrmPesqClientes, frmPesqClientes);
  frmPesqClientes.showModal;
  vPedidoControl.Pedido.Cliente := frmPesqClientes.Cliente;
end;

procedure TfrmCadPedido.btnAlterarClick(Sender: TObject);
begin
  carregarPedido;
  vPedidoControl.Pedido.State := acAlterar;
  edtCodCli.SetFocus;
end;

procedure TfrmCadPedido.btnConfirmarClick(Sender: TObject);
begin
  vPedidoControl.Salvar;
end;

procedure TfrmCadPedido.btnIncluirClick(Sender: TObject);
begin
  LimparCampos;
  edtNumero.Text := IntToStr(vPedidoControl.ProximoNumero);
  vPedidoControl.Pedido.State := acIncluir;
  edtCodCli.SetFocus;
end;

procedure TfrmCadPedido.btnInserirItemClick(Sender: TObject);
Var
  vItem: TItemPedido;
  vProduto: TProdutoControl;
begin
  if (StrToIntDef(edtCodProd.text, 0)> 0) And (StrToIntDef(edtQtd.text,0)>0) then
  begin
    vItem := TItemPedido.Create;
    vProduto := TProdutoControl.Create;
    try
      vItem.IdPedido := vPedidoControl.Pedido.IdPedido;
      vItem.Produto  := vProduto.GetProduto(StrToIntDef(edtCodProd.text, 0));
      vItem.Qtd      := StrToInt(edtQtd.text);
      vPedidoControl.Pedido.AdcionarItem(vItem);

      qryItens.Append;
      qryItensCodProd.AsInteger := vItem.Produto.Codigo;
      qryItensPreco.AsFloat     := vItem.Produto.Preco;
      qryItensQtd.AsInteger     := vItem.Qtd;
      qryItensTotalItem.AsFloat := vItem.TotalItem;
      qryItens.Post;
    finally
      FreeAndNil(vItem);
    end;
  end
  else
  begin
    edtCodProd.SetFocus;
    raise Exception.Create('É necessário informar um produto é uma quantidade maior que zero!');
  end;

end;

procedure TfrmCadPedido.btnPesqPedidoClick(Sender: TObject);
Var
  vQryPedido: TFDQuery;
begin
  if StrToIntDef(edtNumeroPesq.Text, 0) > 0 then
  begin
    try
      qryPedido.Close;
      qryItens.Close;
      vQryPedido := vPedidoControl.BuscarPedido(StrToInt(edtNumeroPesq.Text));
      qryPedido.Data := vQryPedido.Data;
      vPedidoControl.Pedido := vQryPedido.AsObject<TPedido>;
      BuscaItensPedido;
      PreencheEditsCabecalho;
    finally
      vQryPedido.close;
      FreeAndNil(vQryPedido);
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

procedure TfrmCadPedido.CarregarPedido;
begin
  btnPesqPedidoClick(self);
end;

procedure TfrmCadPedido.dbgItensKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = VK_DELETE) then
  begin
    if (Application.MessageBox(PChar('Deseja realmente excluir o registro!'),
      'Confirmação', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)= mrYes) then
    begin
      vPedidoControl.Pedido.RemoverItem(qryItensCodProd.AsInteger);
    end;
  end;
end;

procedure TfrmCadPedido.edtCodProdExit(Sender: TObject);
Var
  vQry: TFDQuery;
  vProdutoControl: TProdutoControl;
begin
  if StrToIntDef(edtCodProd.Text, 0)> 0 then
  begin
    try
      vProdutoControl := TProdutoControl.Create();
      vQry := vProdutoControl.BuscarPorCodigo(StrToInt(edtCodCli.Text));
      try
        if (vQry.IsEmpty) then
        begin
          edtCodProd.Text          := vQry.FieldByName('CODIGO').AsString;
          edtDescricaoProduto.Text := vQry.FieldByName('NOME').AsString;
        end
        else
        begin
          Application.MessageBox(Phar('Cliente não localizado!'));
          edtCodCli.Clear;
          edtCliente.Clear;
          edtCodCli.SetFocus;
        end;
      finally
        vQry.Close;
        FreeAndNil(vQry);
        FreeAndNil(vProdutoControl);
      end;
    except on e:exception do
      raise Exception.Create('Erro buscar dados do cliente!'+e.ToString);
    end;
  end;
end;

procedure TfrmCadPedido.edtQtdKeyPress(Sender: TObject; var Key: Char);
begin
  if Not (key in ['0'..'9', #08]) then
    key := #0;
end;

procedure TfrmCadPedido.edtCodCliExit(Sender: TObject);
Var
  vClienteControl: TClienteControl;
  vQry: TFDQuery;
begin
  if StrToIntDef(edtCodCli.Text, 0)> 0 then
  begin
    try
      vClienteControl := TClienteControl.Create();
      vQry := vClienteControl.BuscarPorCodigo(StrToInt(edtCodCli.Text));
      try
        if (vQry.IsEmpty) then
        begin
          edtCodCli.Text := vQry.FieldByName('CODIGO').AsString;
          edtCliente.Text:= vQry.FieldByName('NOME').AsString;
        end
        else
        begin
          Application.MessageBox(Phar('Cliente não localizado!'));
          edtCodCli.Clear;
          edtCliente.Clear;
          edtCodCli.SetFocus;
        end;
      finally
        vQry.Close;
        FreeAndNil(vQry);
        FreeAndNil(vClienteControl);
      end;
    except on e:exception do
      raise Exception.Create('Erro buscar dados do cliente!'+e.ToString);
    end;
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

procedure TfrmCadPedido.BuscaItensPedido;
Var
  vQryItens: TFDQuery;
begin
  if Not(qryPedido.IsEmpty)then
  begin
    try
      vQryItens     := vPedidoControl.BuscarItensPedido(qryPedidoIdPedido.AsInteger);
      qryItens.Data := vQryItens.Data;
    finally
      vQryItens.Close;
      FreeAndNil(vQryItens);
    end;
  end;
end;

procedure TfrmCadPedido.PreencheEditsCabecalho;
begin
  if Not(qryPedido.IsEmpty) then
  begin
    edtNumero.Text  := qryPedidoNumero.AsString;
    edtCodCli.Text  := qryPedidoCODCLI.AsString;
    edtCliente.Text := qryPedidoCliente.AsString;
    dtpDataCad.Date := qryPedidoDTCADASTRO.AsDateTime;
  end;

end;
procedure TfrmCadPedido.TotalPedido;
begin
  if qryPedido.State in [dsInsert, dsEdit] then
    qryPedidoTotal.AsFloat := vPedidoControl.Pedido.Total;
end;

end.
