object frmCadUsers: TfrmCadUsers
  Left = 0
  Top = 0
  Caption = 'Modelo de Sistema Comercial Multiusu'#225'rio - Cadastro de Usu'#225'rios'
  ClientHeight = 441
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 176
    Width = 913
    Height = 240
    DataSource = dsUsers
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'USER_ID'
        Title.Alignment = taCenter
        Title.Caption = 'ID'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_NAME'
        Title.Alignment = taCenter
        Title.Caption = 'Nome do Usu'#225'rio'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_LOGIN'
        Title.Alignment = taCenter
        Title.Caption = 'Login'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_PASSWORD'
        Title.Alignment = taCenter
        Title.Caption = 'Senha'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREDENTIAL'
        Title.Alignment = taCenter
        Title.Caption = 'Credencial'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 84
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'USER_CLEARANCE'
        Title.Caption = 'N'#237'vel de Acesso'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_STYLE'
        Title.Alignment = taCenter
        Title.Caption = 'Estilo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'calcFieldSimOuNao'
        Title.Alignment = taCenter
        Title.Caption = 'Login restrito ?'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_PC_NAME'
        Title.Caption = 'Nome do Computador'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object dbLedt_ID: TDBLabeledEdit
    Left = 8
    Top = 40
    Width = 57
    Height = 23
    TabStop = False
    DataField = 'USER_ID'
    DataSource = dsUsers
    ReadOnly = True
    TabOrder = 0
    EditLabel.Width = 42
    EditLabel.Height = 15
    EditLabel.Caption = 'User ID'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
  end
  object dbLedt_user: TDBLabeledEdit
    Left = 71
    Top = 40
    Width = 177
    Height = 23
    DataField = 'USER_NAME'
    DataSource = dsUsers
    TabOrder = 1
    OnExit = dbLedt_userExit
    OnKeyPress = dbLedt_userKeyPress
    EditLabel.Width = 102
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome do usu'#225'rio *'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
  end
  object dbLedt_senha: TDBLabeledEdit
    Left = 416
    Top = 40
    Width = 200
    Height = 23
    DataField = 'USER_PASSWORD'
    DataSource = dsUsers
    TabOrder = 2
    EditLabel.Width = 42
    EditLabel.Height = 15
    EditLabel.Caption = 'Senha *'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 145
    Width = 240
    Height = 25
    DataSource = dsUsers
    TabOrder = 3
    TabStop = True
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 422
    Width = 1008
    Height = 19
    Panels = <
      item
        Text = 'Usu'#225'rio: '
        Width = 150
      end
      item
        Text = 'Credencial: '
        Width = 200
      end
      item
        Alignment = taRightJustify
        Text = 'Desenvolvido por Mancuso Software'#169' 2025     '
        Width = 50
      end>
  end
  object DBLabeledEdit1: TDBLabeledEdit
    Left = 263
    Top = 40
    Width = 138
    Height = 23
    DataField = 'USER_LOGIN'
    DataSource = dsUsers
    TabOrder = 6
    OnExit = dbLedt_userExit
    OnKeyPress = dbLedt_userKeyPress
    EditLabel.Width = 38
    EditLabel.Height = 15
    EditLabel.Caption = 'Login *'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
  end
  object DBLabeledEdit2: TDBLabeledEdit
    Left = 71
    Top = 96
    Width = 177
    Height = 23
    DataField = 'USER_CREDENTIAL'
    DataSource = dsUsers
    TabOrder = 7
    EditLabel.Width = 66
    EditLabel.Height = 15
    EditLabel.Caption = 'Credencial *'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
  end
  object DBLabeledEdit3: TDBLabeledEdit
    Left = 263
    Top = 96
    Width = 90
    Height = 23
    DataField = 'USER_CLEARANCE'
    DataSource = dsUsers
    TabOrder = 8
    EditLabel.Width = 95
    EditLabel.Height = 15
    EditLabel.Caption = 'N'#237'vel de Acesso *'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
  end
  object DBchkPC_RESTRITO: TDBCheckBox
    Left = 416
    Top = 80
    Width = 273
    Height = 17
    Caption = 'O usu'#225'rio s'#243' pode fazer login no computador:'
    DataField = 'USER_PC_RESTRICTED'
    DataSource = dsUsers
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object DBlblPC_NOME: TDBLabeledEdit
    Left = 416
    Top = 119
    Width = 129
    Height = 23
    DataField = 'USER_PC_NAME'
    DataSource = dsUsers
    TabOrder = 10
    EditLabel.Width = 125
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome do computador:'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
  end
  object TbUsers: TFDQuery
    AfterInsert = TbUsersAfterInsert
    OnCalcFields = TbUsersCalcFields
    Connection = dm.FDConnection1
    SQL.Strings = (
      'SELECT * FROM TB_USERS')
    Left = 424
    Top = 232
    object TbUsersUSER_ID: TFDAutoIncField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object TbUsersUSER_NAME: TWideStringField
      FieldName = 'USER_NAME'
      Origin = 'USER_NAME'
      Size = 40
    end
    object TbUsersUSER_LOGIN: TWideStringField
      FieldName = 'USER_LOGIN'
      Origin = 'USER_LOGIN'
      Size = 15
    end
    object TbUsersUSER_PASSWORD: TWideStringField
      FieldName = 'USER_PASSWORD'
      Origin = 'USER_PASSWORD'
      Size = 8
    end
    object TbUsersUSER_CREDENTIAL: TWideStringField
      FieldName = 'USER_CREDENTIAL'
      Origin = 'USER_CREDENTIAL'
    end
    object TbUsersUSER_CLEARANCE: TSmallintField
      FieldName = 'USER_CLEARANCE'
      Origin = 'USER_CLEARANCE'
    end
    object TbUsersUSER_STYLE: TWideStringField
      FieldName = 'USER_STYLE'
      Origin = 'USER_STYLE'
      Size = 30
    end
    object TbUsersUSER_PC_RESTRICTED: TBooleanField
      FieldName = 'USER_PC_RESTRICTED'
      Origin = 'USER_PC_RESTRICTED'
      Required = True
    end
    object TbUsersUSER_PC_NAME: TWideStringField
      FieldName = 'USER_PC_NAME'
      Origin = 'USER_PC_NAME'
      Size = 15
    end
    object TbUserscalcFieldSimOuNao: TStringField
      FieldKind = fkCalculated
      FieldName = 'calcFieldSimOuNao'
      Size = 3
      Calculated = True
    end
  end
  object dsUsers: TDataSource
    AutoEdit = False
    DataSet = TbUsers
    Left = 544
    Top = 232
  end
end
