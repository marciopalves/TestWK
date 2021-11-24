program prjTestWk;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  uFrmCadPedidoView in 'view\uFrmCadPedidoView.pas' {frmCadPedido},
  uAcaoEnum in 'model\uAcaoEnum.pas',
  uProdutoModel in 'model\uProdutoModel.pas',
  uClienteModel in 'model\uClienteModel.pas',
  uClienteDao in 'dao\uClienteDao.pas',
  uProdutoDao in 'dao\uProdutoDao.pas',
  uPedidoModel in 'model\uPedidoModel.pas',
  uItemModel in 'model\uItemModel.pas',
  uPedidoDao in 'dao\uPedidoDao.pas',
  uDmConexao in 'dao\uDmConexao.pas' {DMConexao: TDataModule},
  uPedidoControl in 'Controler\uPedidoControl.pas',
  uFrmPesqCliente in 'view\uFrmPesqCliente.pas' {frmPesqClientes: TFrame},
  uClienteControl in 'Controler\uClienteControl.pas',
  uProdutoControl in 'Controler\uProdutoControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.Run;
end.
