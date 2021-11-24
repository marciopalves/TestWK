object frmCadPedido: TfrmCadPedido
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pedidos'
  ClientHeight = 299
  ClientWidth = 702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 702
    Height = 57
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 38
      Height = 13
      Caption = 'Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNumeroPesq: TEdit
      Left = 16
      Top = 25
      Width = 121
      Height = 21
      TabOrder = 0
      OnKeyPress = edtNumeroPesqKeyPress
    end
    object btnPesqPedido: TButton
      Left = 179
      Top = 23
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btnPesqPedidoClick
    end
    object pnlBotoes: TPanel
      Left = 467
      Top = 1
      Width = 234
      Height = 55
      Align = alRight
      TabOrder = 2
      object btnIncluir: TButton
        Left = 8
        Top = 1
        Width = 75
        Height = 49
        Caption = 'Incluir'
        TabOrder = 0
        OnClick = btnIncluirClick
      end
      object btnAlterar: TButton
        Left = 82
        Top = 1
        Width = 75
        Height = 49
        Caption = 'Alterar'
        TabOrder = 1
        OnClick = btnAlterarClick
      end
      object Button2: TButton
        Left = 156
        Top = 1
        Width = 75
        Height = 49
        Caption = 'Excluir'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 57
    Width = 702
    Height = 242
    ActivePage = tsPedido
    Align = alClient
    TabOrder = 1
    object tsPesquisa: TTabSheet
      Caption = 'Pesquisa'
      object grdPedidos: TDBGrid
        Left = 0
        Top = 0
        Width = 694
        Height = 214
        Align = alClient
        DataSource = dsPedido
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Numero'
            Width = 84
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DTCADASTRO'
            Title.Caption = 'Dt. Pedido'
            Width = 83
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODCLI'
            Title.Caption = 'Cod. Cliente'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cliente'
            Width = 286
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL'
            Title.Caption = 'Total'
            Visible = True
          end>
      end
    end
    object tsPedido: TTabSheet
      Caption = 'Pedido'
      ImageIndex = 1
      object pnlItens: TPanel
        Left = 0
        Top = 105
        Width = 694
        Height = 70
        Align = alTop
        TabOrder = 0
        object dbgItens: TDBGrid
          Left = 1
          Top = 1
          Width = 692
          Height = 68
          Align = alClient
          DataSource = dsItens
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnKeyPress = dbgItensKeyPress
          Columns = <
            item
              Expanded = False
              FieldName = 'IdItem'
              Title.Caption = 'Cod. Item'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CodProd'
              Title.Caption = 'Cod. Produto'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              Title.Caption = 'Descri'#231#227'o'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Qtd'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Preco'
              Title.Caption = 'Pre'#231'o'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TotalItem'
              Title.Caption = 'Total Item'
              Visible = True
            end>
        end
      end
      object pnlCabecalhoPedido: TPanel
        Left = 0
        Top = 0
        Width = 694
        Height = 57
        Align = alTop
        TabOrder = 1
        object lblNumero: TLabel
          Left = 15
          Top = 2
          Width = 37
          Height = 13
          Caption = 'Numero'
        end
        object Label2: TLabel
          Left = 109
          Top = 2
          Width = 33
          Height = 13
          Caption = 'Cliente'
        end
        object lblDtCadastro: TLabel
          Left = 487
          Top = 3
          Width = 62
          Height = 13
          Caption = 'Dt. Cadastro'
        end
        object Label3: TLabel
          Left = 578
          Top = 2
          Width = 24
          Height = 13
          Caption = 'Total'
        end
        object edtNumero: TEdit
          Left = 15
          Top = 17
          Width = 87
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object edtCodCli: TEdit
          Left = 107
          Top = 17
          Width = 42
          Height = 21
          Hint = 'F2 Para Pesquisa de clientes'
          TabOrder = 1
          OnExit = edtCodCliExit
        end
        object edtCliente: TEdit
          Left = 152
          Top = 17
          Width = 326
          Height = 21
          Hint = 'F2 Para Pesquisa de clientes'
          Enabled = False
          TabOrder = 2
        end
        object dtpDataCad: TDateTimePicker
          Left = 487
          Top = 17
          Width = 80
          Height = 21
          Date = 44518.389664988430000000
          Time = 44518.389664988430000000
          TabOrder = 3
        end
        object edtTotal: TEdit
          Left = 576
          Top = 17
          Width = 89
          Height = 21
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 4
          Text = '0'
        end
      end
      object pnlIncusaoItens: TPanel
        Left = 0
        Top = 57
        Width = 694
        Height = 48
        Align = alTop
        TabOrder = 2
        object Label4: TLabel
          Left = 15
          Top = 3
          Width = 38
          Height = 13
          Caption = 'Produto'
        end
        object Label5: TLabel
          Left = 391
          Top = 3
          Width = 27
          Height = 13
          Caption = 'Preco'
        end
        object Label6: TLabel
          Left = 487
          Top = 3
          Width = 18
          Height = 13
          Caption = 'Qtd'
        end
        object btnInserirItem: TButton
          Left = 576
          Top = 13
          Width = 75
          Height = 25
          Caption = 'Incluir'
          TabOrder = 0
          OnClick = btnInserirItemClick
        end
        object edtCodProd: TEdit
          Left = 15
          Top = 17
          Width = 42
          Height = 21
          TabOrder = 1
          OnExit = edtCodProdExit
        end
        object edtDescricaoProduto: TEdit
          Left = 61
          Top = 17
          Width = 326
          Height = 21
          Enabled = False
          TabOrder = 2
        end
        object edtPreco: TEdit
          Left = 391
          Top = 17
          Width = 89
          Height = 21
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 3
          Text = '0'
        end
        object edtQtd: TEdit
          Left = 487
          Top = 17
          Width = 66
          Height = 21
          Alignment = taRightJustify
          TabOrder = 4
          Text = '0'
          OnKeyPress = edtQtdKeyPress
        end
      end
      object pnlRodape: TPanel
        Left = 0
        Top = 181
        Width = 694
        Height = 33
        Align = alBottom
        TabOrder = 3
        object btnConfirmar: TButton
          Left = 485
          Top = 1
          Width = 75
          Height = 25
          Caption = 'Confirmar'
          TabOrder = 0
          OnClick = btnConfirmarClick
        end
        object btnCancelar: TButton
          Left = 589
          Top = 1
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          TabOrder = 1
        end
      end
    end
  end
  object qryPedido: TFDQuery
    Connection = DMConexao.FDConnection
    Left = 316
    Top = 1
    object qryPedidoNumero: TIntegerField
      FieldName = 'Numero'
    end
    object qryPedidoIdPedido: TIntegerField
      FieldName = 'IdPedido'
    end
    object qryPedidoCODCLI: TIntegerField
      FieldName = 'CODCLI'
    end
    object qryPedidoDTCADASTRO: TDateField
      FieldName = 'DTCADASTRO'
    end
    object qryPedidoCliente: TStringField
      FieldName = 'Cliente'
    end
    object qryPedidoTOTAL: TFloatField
      FieldName = 'TOTAL'
    end
  end
  object dsPedido: TDataSource
    DataSet = qryPedido
    Left = 374
  end
  object qryItens: TFDQuery
    Connection = DMConexao.FDConnection
    Left = 308
    Top = 201
    object qryItensIdItem: TIntegerField
      FieldName = 'IdItem'
    end
    object qryItensIdPedido: TIntegerField
      FieldName = 'IdPedido'
    end
    object qryItensCodProd: TIntegerField
      FieldName = 'CodProd'
    end
    object qryItensQtd: TFloatField
      FieldName = 'Qtd'
    end
    object qryItensPreco: TFloatField
      FieldName = 'Preco'
    end
    object qryItensTotalItem: TFloatField
      FieldName = 'TotalItem'
    end
    object qryItensDescricao: TStringField
      FieldName = 'Descricao'
    end
  end
  object dsItens: TDataSource
    DataSet = qryItens
    Left = 364
    Top = 202
  end
  object ActionList: TActionList
    Left = 604
    Top = 218
    object actPesquisarCliente: TAction
      Caption = 'actPesquisarCliente'
      ShortCut = 113
      OnExecute = actPesquisarClienteExecute
    end
    object actPesquisarProduto: TAction
      Caption = 'actPesquisarProduto'
    end
  end
end
