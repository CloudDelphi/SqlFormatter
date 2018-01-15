(* $Header: /SQL Toys/SqlFormatter/FormSettings.pas 103   18-01-14 20:46 Tomek $
   (c) Tomasz Gierka, github.com/SqlToys, 2012.03.31                          *)
{--------------------------------------  --------------------------------------}
{$IFDEF RELEASE}
  {$DEBUGINFO OFF}
  {$LOCALSYMBOLS OFF}
{$ENDIF}
unit FormSettings;

interface

uses Forms, Controls, StdCtrls, ComCtrls, Classes, ExtCtrls, Graphics, Vcl.ImgList,
     SqlStructs, SqlTokenizers, SqlLister, SqlCommon;

type
  TYaSettingsAction = ( yacsGetFromRegistry, yacsPutToRegistry, yacsDefault );

type
  TFormSettings = class(TForm)

    PanelBtn: TPanel;
    BtnCancel: TButton;
    BtnOK: TButton;
    BtnReset: TButton;
    BtnStored: TButton;
    ButtonEditFont: TButton;
    ButtonGridFont: TButton;
    GroupBoxLines: TGroupBox;
    ChkBoxEmptyLinesBeforeClauses: TCheckBox;
    ChkBoxEmptyLinesAroundUnion: TCheckBox;
    ChkBoxEmptyLinesBeforeClausesExcSubqueries: TCheckBox;
    ChkBoxEmptyLinesBeforeClausesExcShortQuery: TCheckBox;
    GroupBoxSpacings: TGroupBox;
    ChkBoxSpaceBeforeComma: TCheckBox;
    ChkBoxSpaceBeforeSemicolon: TCheckBox;
    ChkBoxSpaceOutsideBrackets: TCheckBox;
    ChkBoxSpaceInsideBrackets: TCheckBox;
    ChkBoxSpaceAroundOperator: TCheckBox;
    ChkBoxSpaceAfterComma: TCheckBox;
    ChkBoxSpaceInsideBracketsSkipOnFun: TCheckBox;
    ChkBoxSpaceInsideBracketsSkipOnDatatype: TCheckBox;
    GroupBoxIntendation: TGroupBox;
    ChkBoxOneExprOnLine: TCheckBox;
    ChkBoxCommaAtNewLine: TCheckBox;
    ChkBoxOneCondOnLine: TCheckBox;
    ChkBoxSetLeftExprIntend: TCheckBox;
    GroupBox4: TGroupBox;
    ChkBoxCaseAtNewLine: TCheckBox;
    ChkBoxCaseWhenAtNewLine: TCheckBox;
    ChkBoxCaseThenAtNewLine: TCheckBox;
    ChkBoxCaseElseAtNewLine: TCheckBox;
    ChkBoxCaseEndAtNewLine: TCheckBox;
    GroupBox2: TGroupBox;
    ChkBoxSelectAliasIntend: TCheckBox;
    CheckBoxExtQueryKeywordStyle: TCheckBox;
    GroupBox1: TGroupBox;
    ChkBoxFromTableAndAliasIntend: TCheckBox;
    ChkBoxOnCondIntend: TCheckBox;
    GroupBoxCreateTable: TGroupBox;
    CheckBoxCreateTableColConstrBreakLine: TCheckBox;
    CheckBoxCreateTableColConstrNewLineAfter: TCheckBox;
    ChkBoxCreateTableColDatatypeIntend: TCheckBox;
    ChkBoxCreateTableEmptyLineBeforeComplexContraints: TCheckBox;
    GroupBox5: TGroupBox;
    ChkBoxNoSemicolonOnSingleQuery: TCheckBox;
    ChkBoxColumnConstraint: TCheckBox;
    ChkBoxRightIntend: TCheckBox;
    TreeView1: TTreeView;
    Label1: TLabel;
    GroupBoxLengths: TGroupBox;
    LabelColMaxLen: TLabel;
    EditColMaxLen: TEdit;
    LabelMaxDatatypeLen: TLabel;
    EditMaxDataTypeLen: TEdit;
    LabelTableMaxLen: TLabel;
    EditTableMaxLen: TEdit;
    LabelAliasMaxLen: TLabel;
    EditAliasMaxLen: TEdit;
    LabelMaxClauseKeywordIntend: TLabel;
    LabelMaxIdentifierLength: TLabel;
    EditMaxIdentifierLength: TEdit;
    EditMaxClauseKeywordIntend: TEdit;
    GroupBoxLinesCount: TGroupBox;
    Label2: TLabel;
    ChkBoxLinesNoAfterQuery: TCheckBox;
    EditLinesNoAfterQuery: TEdit;
    EditShortQuery: TEdit;
    ImageList1: TImageList;

    procedure FormShow(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure BtnResetClick(Sender: TObject);
    procedure BtnStoredClick(Sender: TObject);

    procedure ButtonEditFontClick(Sender: TObject);

    procedure ChkBoxAction       (aAction: TYaSettingsAction);
    procedure ComboAction        (aAction: TYaSettingsAction);
    procedure EditAction         (aAction: TYaSettingsAction);
    procedure ButtonGridFontClick(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ScriptEditFont, DBGridFont: TFont;
  end;

type
  TYaIntSettings = ( yastWindowTop, yastWindowLeft, yastWindowState, yastWindowHeight, yastWindowWidth,
                     yastSplitterWidth, yastSplitterHeight, yastEditFontSize, yastGridFontSize );

var
  YA_SET_INT_ARR : array [ TYaIntSettings ]
  of record Key: TYaRegKey; Reg: String; Def: Integer end
  = ( (Key: yarkCommon;   Reg: 'MainWindowTop';     Def: 0),
      (Key: yarkCommon;   Reg: 'MainWindowLeft';    Def: 0),
      (Key: yarkCommon;   Reg: 'MainWindowState';   Def: Ord(wsNormal)),
      (Key: yarkCommon;   Reg: 'MainWindowHeight';  Def: 600),
      (Key: yarkCommon;   Reg: 'MainWindowWidth';   Def: 800),
      (Key: yarkCommon;   Reg: 'TreePanelWidth';    Def: 200),
      (Key: yarkCommon;   Reg: 'TreePanelHeight';   Def: 100),
      (Key: yarkCommon;   Reg: 'EditFontSize';      Def: 13),
      (Key: yarkCommon;   Reg: 'GridFontSize';      Def: 13)
  );

procedure YaRegistryPutInt(aSett: TYaIntSettings; aValue: Integer; aForce: Boolean = False);
function  YaRegistryGetInt(aSett: TYaIntSettings; aValue: Integer = 0): Integer;

type
  TYaStrSettings = ( yastEditFontName, yastLastConnection, yastGridFontName );

var
  YA_SET_STR_ARR : array [ TYaStrSettings ]
  of record Key: TYaRegKey; Reg: String; Def: String end
  = ( (Key: yarkCommon;   Reg: 'EditFontName';      Def: 'Courier New'),
      (Key: yarkCommon;   Reg: 'LastConnection';    Def: ''),
      (Key: yarkCommon;   Reg: 'GridFontName';      Def: 'Courier New')
  );

procedure YaRegistryPutStr(aSett: TYaStrSettings; aValue: String; aForce: Boolean = False);
function  YaRegistryGetStr(aSett: TYaStrSettings; aValue: String = ''): String;

{------------------------------- Font functions -------------------------------}

const
  YA_MIN_FONT_SIZE = 8;
  YA_MAX_FONT_SIZE = 24;

function YaFontDialog(aFont: TFont): TFont;

{----------------------- Converters TreeView procedures -----------------------}

const { converters settings values, same as icon numbers }
  SQCV_NONE     = 0;
  SQCV_GROUP    = 1;
  SQCV_ADD      = 2;
  SQCV_REMOVE   = 3;
  SQCV_UPPER    = 4;
  SQCV_LOWER    = 5;
  SQCV_SHORT    = 6;
  SQCV_LONG     = 7;

  { converter groups }
  SQCG_CASES    = 1;
  SQCG_KEYWORD  = 2;
  SQCG_DATA     = 3;
  SQCG_JOIN     = 4;
  SQCG_ORDER    = 5;

  { converters = converter items }
  SQCC_NONE              = 0;
  SQCC_CASE_KEYWORD      = 1;
  SQCC_CASE_TABLE        = 2;
  SQCC_CASE_TABLE_ALIAS  = 3;
  SQCC_CASE_COLUMN       = 4;
  SQCC_CASE_COLUMN_ALIAS = 5;
  SQCC_CASE_COLUMN_QUOTE = 6;
  SQCC_CASE_PARAM        = 7;
  SQCC_CASE_FUNC         = 8;
  SQCC_CASE_IDENT        = 9;

  SQCC_KWD_AS_TABLES     = 1;
  SQCC_KWD_AS_COLUMNS    = 2;

  SQCC_DATA_INT          = 1;

  SQCC_JOIN_INNER        = 1;
  SQCC_JOIN_OUTER        = 2;
  SQCC_JOIN_ON_LEFT      = 3;

  SQCC_ORDER_KWD_LEN     = 1;
  SQCC_ORDER_KWD_DEF     = 2;

function  SqlConvertIndex( aGroup, aItem: Integer ): Integer;
function  SqlConvertGroup( aIndex: Integer ): Integer;
function  SqlConvertItem ( aIndex: Integer ): Integer;

function  SqlConvertName( aGroup, aItem: Integer ): String;
function  SqlConvertGetValue( aGroup, aItem: Integer ): Integer;
function  SqlConvertValidateValue( aGroup, aItem, aState: Integer ): Integer;
procedure SqlConvertSetValue( aGroup, aItem, aState: Integer );
function  SqlConvertDefValue( aGroup, aItem: Integer ): Integer;
procedure SqlConvertExecute( aGroup, aItem, aState: Integer; aNode: TGtSqlNode );
procedure SqlConvertExecuteAll( aNode: TGtSqlNode );

implementation

uses Dialogs, SysUtils,
     GtRegistry,
     SqlVersion, SqlConverters;

{$R *.dfm}

{ form show }
procedure TFormSettings.FormShow(Sender: TObject);
var GroupNode, ItemNode: TTreeNode;
    Group, Item: Integer;
begin
  Caption := VER_NAME + ' - Settings...';

  BtnStoredClick(Sender);

  { populate Converters TreeView }
  for Group := 1 to 99 do
    if SqlConvertName( Group, 0 ) <> '' then begin
      GroupNode := TreeView1.Items.AddChild(nil, SqlConvertName( Group, 0 ) );
      GroupNode.ImageIndex := SqlConvertGetValue( Group, 0 );
      GroupNode.SelectedIndex := SqlConvertGetValue( Group, 0 );
      GroupNode.StateIndex := SqlConvertIndex( Group, 0 );

      for Item := 1 to 99 do
      if SqlConvertName( Group, Item ) <> '' then begin
        ItemNode := TreeView1.Items.AddChild( GroupNode, SqlConvertName( Group, Item ) );
        ItemNode.ImageIndex := SqlConvertGetValue( Group, Item );
        ItemNode.SelectedIndex := SqlConvertGetValue( Group, Item );
        ItemNode.StateIndex := SqlConvertIndex( Group, Item );
      end;

      GroupNode.Expanded := True;
    end;
end;

{ TreeView1 Double Click }
procedure TFormSettings.TreeView1DblClick(Sender: TObject);
begin
  if not Assigned(TreeView1.Selected) then Exit;
  if TreeView1.Selected.Level = 0 then Exit;

//  TreeView1.Selected.ImageIndex := TreeView1.Selected.ImageIndex + 1;
//  TreeView1.Selected.SelectedIndex := TreeView1.Selected.SelectedIndex + 1;

  TreeView1.Selected.ImageIndex := SqlConvertValidateValue( SqlConvertGroup( TreeView1.Selected.StateIndex )
                                                          , SqlConvertItem( TreeView1.Selected.StateIndex )
                                                          , TreeView1.Selected.ImageIndex + 1);
  TreeView1.Selected.SelectedIndex := TreeView1.Selected.ImageIndex;

  SqlConvertSetValue( SqlConvertGroup( TreeView1.Selected.StateIndex )
                    , SqlConvertItem( TreeView1.Selected.StateIndex )
                    , TreeView1.Selected.ImageIndex );
end;

{ button OK }
procedure TFormSettings.BtnOKClick(Sender: TObject);
begin
  rguDeleteKey( YA_SETTINGS_KEY );
  rguPutStr(YA_VERSION_KEY, VER_NUMBER);

  { commons }
  EditAction(yacsPutToRegistry);
  ComboAction(yacsPutToRegistry);
  ChkBoxAction(yacsPutToRegistry);

  { Close }
  Close;
end;

{ Form Key Press Event }
procedure TFormSettings.FormKeyPress(Sender: TObject; var Key: Char);
begin
  { Escape key - Close Form }
  if Key = #27 then Close;
end;

{ reset to defaults }
procedure TFormSettings.BtnResetClick(Sender: TObject);
begin
  { commons }
  EditAction(yacsDefault);
  ComboAction(yacsDefault);
  ChkBoxAction(yacsDefault);
end;

{ recall stored values }
procedure TFormSettings.BtnStoredClick(Sender: TObject);
begin
  { commons }
  EditAction(yacsGetFromRegistry);
  ComboAction(yacsGetFromRegistry);
  ChkBoxAction(yacsGetFromRegistry);
end;

{ calls Font Dialog for Edit }
procedure TFormSettings.ButtonEditFontClick(Sender: TObject);
begin
  ScriptEditFont := YaFontDialog( ScriptEditFont );
end;

{ calls Font Dialog for Grid }
procedure TFormSettings.ButtonGridFontClick(Sender: TObject);
begin
  DBGridFont := YaFontDialog( DBGridFont );
end;

{ puts YA Integer Setting }
procedure YaRegistryPutInt(aSett: TYaIntSettings; aValue: Integer; aForce: Boolean = False);
begin
  if aForce or (aValue <> YA_SET_INT_ARR [ aSett ].Def)
    then rguPutInt(YaRegKey(YA_SET_INT_ARR [ aSett ].Key) + YA_SET_INT_ARR [ aSett ].Reg, aValue)
    else rguDeleteVal(YaRegKey(YA_SET_INT_ARR [ aSett ].Key) + YA_SET_INT_ARR [ aSett ].Reg);
end;

{ gets YA Integer Setting }
function  YaRegistryGetInt(aSett: TYaIntSettings; aValue: Integer = 0): Integer;
begin
  if aValue = 0 then aValue := YA_SET_INT_ARR [ aSett ].Def;
  Result := rguGetInt(YaRegKey(YA_SET_INT_ARR [ aSett ].Key) + YA_SET_INT_ARR [ aSett ].Reg, aValue);
end;

{ puts YA Integer Setting }
procedure YaRegistryPutStr(aSett: TYaStrSettings; aValue: String; aForce: Boolean = False);
begin
  if aForce or (aValue <> YA_SET_STR_ARR [ aSett ].Def)
    then rguPutStr(YaRegKey(YA_SET_STR_ARR [ aSett ].Key) + YA_SET_STR_ARR [ aSett ].Reg, aValue)
    else rguDeleteVal(YaRegKey(YA_SET_STR_ARR [ aSett ].Key) + YA_SET_STR_ARR [ aSett ].Reg);
end;

{ gets YA Integer Setting }
function  YaRegistryGetStr(aSett: TYaStrSettings; aValue: String = ''): String;
begin
  if aValue = '' then aValue := YA_SET_STR_ARR [ aSett ].Def;
  Result := rguGetStr(YaRegKey(YA_SET_STR_ARR [ aSett ].Key) + YA_SET_STR_ARR [ aSett ].Reg, aValue);
end;

{ sets chain between visual controls and their ids }
procedure TFormSettings.ChkBoxAction(aAction: TYaSettingsAction);

  procedure LocalAction(aAction: TYaSettingsAction; aSetting: TGtListerSettings; aCheckBox: TCheckBox);
  begin
    case aAction of
      yacsGetFromRegistry:  aCheckBox.Checked := GtRegistryGetBool (aSetting);
      yacsPutToRegistry:    GtRegistryPutBool(aSetting, aCheckBox.Checked);
      yacsDefault:          aCheckBox.Checked := GT_SET_BOOL_ARR [aSetting].Def;
    end;
  end;

  procedure LocalAction2(aAction: TYaSettingsAction; aSetting: TYaBoolSettings; aCheckBox: TCheckBox);
  begin
    case aAction of
      yacsGetFromRegistry:  aCheckBox.Checked := YaRegistryGetBool (aSetting);
      yacsPutToRegistry:    YaRegistryPutBool(aSetting, aCheckBox.Checked);
      yacsDefault:          aCheckBox.Checked := YA_SET_BOOL_ARR [aSetting].Def;
    end;
  end;

begin
  LocalAction (aAction, gtstExtQueryKeywordStyle,    CheckBoxExtQueryKeywordStyle);

  { general }
  LocalAction (aAction, gtstNoSemicolonOnSingleQuery,ChkBoxNoSemicolonOnSingleQuery);
//LocalAction (aAction, gtstJoinCondLeftSideOrderCONVERTER,CheckBoxJoinCondLeftSideOrder);
//LocalAction (aAction, gtstOnCondRefsFirstCONVERTER,CheckBoxJoinCondRefsFirst);

  { lines }
//LocalAction(aAction, gtstLineAfterQuery,          ChkBoxEmptyLineAfterQuery);
  LocalAction(aAction, gtstLinesNoAfterQuery,       ChkBoxLinesNoAfterQuery);
  LocalAction(aAction, gtstEmptyLineBeforeClause,   ChkBoxEmptyLinesBeforeClauses);
  LocalAction(aAction, gtstEmptyLineBeforeClauseSkipSubquery,ChkBoxEmptyLinesBeforeClausesExcSubqueries);
  LocalAction(aAction, gtstEmptyLineBeforeClauseSkipShort,ChkBoxEmptyLinesBeforeClausesExcShortQuery);
  LocalAction(aAction, gtstEmptyLineAroundUnion,    ChkBoxEmptyLinesAroundUnion);

  { CREATE TABLE }
  LocalAction(aAction, gtstCreateTable_ColConsBreakLine,CheckBoxCreateTableColConstrBreakLine);
  LocalAction(aAction, gtstCreateTable_ColConsNewLineAfter,CheckBoxCreateTableColConstrNewLineAfter);
  LocalAction(aAction, gtstCreateTable_Intend,       ChkBoxCreateTableColDatatypeIntend);
  LocalAction(aAction, gtstCreateTable_EmptyLineBefComplexConstr,ChkBoxCreateTableEmptyLineBeforeComplexContraints);

  { spacings }
  LocalAction(aAction, gtstRightIntend,             ChkBoxRightIntend);
  LocalAction(aAction, gtstSpaceBeforeSemicolon,    ChkBoxSpaceBeforeSemicolon);
  LocalAction(aAction, gtstSpaceInsideBrackets,     ChkBoxSpaceInsideBrackets);
  LocalAction(aAction, gtstSpaceInsideBracketsSkipFun,ChkBoxSpaceInsideBracketsSkipOnFun);
  LocalAction(aAction, gtstSpaceInsideBracketsSkipDatatype,ChkBoxSpaceInsideBracketsSkipOnDatatype);
  LocalAction(aAction, gtstSpaceOutsideBrackets,    ChkBoxSpaceOutsideBrackets);
  LocalAction(aAction, gtstSpaceAroundOperator,     ChkBoxSpaceAroundOperator);
  LocalAction(aAction, gtstSpaceBeforeComma,        ChkBoxSpaceBeforeComma);
  LocalAction(aAction, gtstSpaceAfterComma,         ChkBoxSpaceAfterComma);

  { intendation }
  LocalAction(aAction, gtstOneExprOnLine,           ChkBoxOneExprOnLine);
  LocalAction(aAction, gtstCommaAtNewLine,          ChkBoxCommaAtNewLine);
  LocalAction(aAction, gtstOneCondOnLine,           ChkBoxOneCondOnLine);
  LocalAction(aAction, gtstCaseAtNewLine,           ChkBoxCaseAtNewLine);
  LocalAction(aAction, gtstCaseWhenAtNewLine,       ChkBoxCaseWhenAtNewLine);
  LocalAction(aAction, gtstCaseThenAtNewLine,       ChkBoxCaseThenAtNewLine);
  LocalAction(aAction, gtstCaseElseAtNewLine,       ChkBoxCaseElseAtNewLine);
  LocalAction(aAction, gtstCaseEndAtNewLine,        ChkBoxCaseEndAtNewLine);
  LocalAction(aAction, gtstTableAndAliasIntend,     ChkBoxFromTableAndAliasIntend);
  LocalAction(aAction, gtstSetExprIntend,           ChkBoxSetLeftExprIntend);
  LocalAction(aAction, gtstOnCondIntend,            ChkBoxOnCondIntend);

  { keywords }
//LocalAction(aAction, gtstExprAsKeywordCONVERTER,  ChkBoxExprAs);
//LocalAction(aAction, gtstTableAsKeywordCONVERTER, ChkBoxTableAs);
  LocalAction(aAction, gtstColumnConstraint,        ChkBoxColumnConstraint);
//LocalAction(aAction, gtstInnerJoinCONVERTER,      ChkBoxInnerJoins);
//LocalAction(aAction, gtstOuterJoinCONVERTER,      ChkBoxOuterJoins);
//LocalAction(aAction, gtstSortShortCONVERTER,      ChkBoxSortShort);
//LocalAction(aAction, gtstSkipAscendingCONVERTER,  ChkBoxSkipAscending);

  { case }
  LocalAction(aAction, gtstSelectAliasIntend,       ChkBoxSelectAliasIntend);
end;

{ sets chain between visual controls and their ids }
procedure TFormSettings.ComboAction(aAction: TYaSettingsAction);

  procedure LocalAction(aAction: TYaSettingsAction; aSetting: TGtListerCaseSettings; aComboBox: TComboBox);
  begin
    case aAction of
      yacsGetFromRegistry:  aComboBox.ItemIndex := Ord(GtRegistryGetCase(aSetting));
      yacsPutToRegistry:    GtRegistryPutCase(aSetting, aComboBox.ItemIndex);
      yacsDefault:          aComboBox.ItemIndex := Ord(GT_SET_CASE_ARR [aSetting].Def);
    end;
  end;

begin
//LocalAction (aAction, gtlcTableCONVERTER,            ComboBoxTableNameCase);
//LocalAction (aAction, gtlcColumnCONVERTER,           ComboBoxColumnNameCase);
//LocalAction (aAction, gtlcTableAliasCONVERTER,       ComboBoxTableAliasCase);
//LocalAction (aAction, gtlcColumnAliasCONVERTER,      ComboBoxColumnAliasCase);
//LocalAction (aAction, gtlcColumnQuotedAliasCONVERTER,ComboBoxColumnQuotedAliasCase);
//LocalAction (aAction, gtlcParameterCONVERTER,        ComboBoxParameterCase);
//LocalAction (aAction, gtlcIdentifierCONVERTER,       ComboBoxIdentifierCase);
//LocalAction (aAction, gtlcKeyword,                   ComboBoxKeywordCase);
//LocalAction (aAction, gtlcFunctionCONVERTER,         ComboBoxFunctionCase);
end;

{ sets chain between visual controls and their ids }
procedure TFormSettings.EditAction(aAction: TYaSettingsAction);

  procedure LocalAction(aAction: TYaSettingsAction; aReg: String; aEdit: TEdit; aDef: String);
  begin
    case aAction of
      yacsGetFromRegistry:  aEdit.Text := rguGetStr(aReg, aDef);
      yacsPutToRegistry:    rguPutStr(aReg, aEdit.Text);
      yacsDefault:          aEdit.Text := aDef;
    end;
  end;

begin
  LocalAction(aAction, YA_SET_KEY_TAB_MAX_LEN,          EditTableMaxLen, '30');
  LocalAction(aAction, YA_SET_KEY_ALIAS_MAX_LEN,        EditAliasMaxLen, '10');

//LocalAction(aAction, YA_SET_KEY_SET_MAX_LEN,          EditSetMaxLen,   '30'); // 20

  LocalAction(aAction, YA_SET_KEY_COL_MAX_LEN,          EditColMaxLen, '20');
  LocalAction(aAction, YA_SET_KEY_TYPE_MAX_LEN,         EditMaxDataTypeLen, '20');

  LocalAction(aAction, YA_SET_KEY_SHORT_QUERY,          EditShortQuery, '20');
  LocalAction(aAction, YA_SET_KEY_MAX_CLAUSE_KEYWORD_INT, EditMaxClauseKeywordIntend, '15');
  LocalAction(aAction, YA_SET_KEY_MAX_IDENTIFIER_LEN,   EditMaxIdentifierLength, '30');

  LocalAction(aAction, YA_SET_KEY_LINES_AFTER_QUERY,    EditLinesNoAfterQuery, '3');
end;

{------------------------------- Font functions -------------------------------}

{ calls Font Dialog for Edit }
function YaFontDialog(aFont: TFont): TFont;
var Dlg : TFontDialog;
begin
  Result := aFont;
  if Assigned(Result) then Result.Style := [];

  Dlg := TFontDialog.Create(Application.MainForm);
  try
    Dlg.Font.Assign( aFont );
    Dlg.Font.Style := [];
    Dlg.Options := [fdFixedPitchOnly, fdApplyButton, fdLimitSize];

    Dlg.MinFontSize := YA_MIN_FONT_SIZE;
    Dlg.MaxFontSize := YA_MAX_FONT_SIZE;

    if Dlg.Execute then begin
      Result.Assign( Dlg.Font );
      Result.Style := [];
    end;
  finally
    Dlg.Free;
  end;
end;

{----------------------- Converters TreeView procedures -----------------------}

{ returns converter index }
function  SqlConvertIndex( aGroup, aItem: Integer ): Integer;
begin
  Result := aGroup*1000 + aItem*10 ;
end;

{ returns converter group no }
function  SqlConvertGroup( aIndex: Integer ): Integer;
begin
  Result := aIndex div 1000;
end;

{ returns converter item no }
function  SqlConvertItem ( aIndex: Integer ): Integer;
begin
  Result := (aIndex div 10) mod 100;
end;

{ returns converter value }
function  SqlConvertGetValue( aGroup, aItem: Integer ): Integer;
begin
  if aItem = 0 then Result := SQCV_GROUP else
  if SqlConvertName( aGroup, aItem ) = '' then Result := SQCV_GROUP else
     Result := SqlConvertValidateValue( aGroup, aItem,
               rguGetInt( YA_SETTINGS_KEY + SqlConvertName( aGroup, 0 ) + '_' + SqlConvertName( aGroup, aItem )
                        , SqlConvertDefValue( aGroup, aItem ) ) );
end;

{ storing converter values }
procedure SqlConvertSetValue( aGroup, aItem, aState: Integer );
begin
  if aItem = 0 then Exit;
  if SqlConvertName( aGroup, 0 ) = '' then Exit;
  if SqlConvertName( aGroup, aItem ) = '' then Exit;

  rguPutInt( YA_SETTINGS_KEY + SqlConvertName( aGroup, 0 ) + '_' + SqlConvertName( aGroup, aItem ), aState );
end;

{ validates converter value }
function  SqlConvertValidateValue( aGroup, aItem, aState: Integer ): Integer;
begin
  Result := SQCV_NONE;

  if aItem = SQCC_NONE then begin
    Result := SQCV_GROUP;
    Exit;
  end;

  if aState <= SQCV_NONE then Result := SQCV_NONE else
  case aGroup of
    SQCG_CASES    : if aState <= SQCV_UPPER  then Result := SQCV_UPPER  else
                    if aState <= SQCV_LOWER  then Result := SQCV_LOWER  else Result := SQCV_NONE ;
    SQCG_KEYWORD  : if aState <= SQCV_ADD    then Result := SQCV_ADD    else
                    if aState <= SQCV_REMOVE then Result := SQCV_REMOVE else Result := SQCV_NONE ;
    SQCG_DATA     : if aState <= SQCV_SHORT  then Result := SQCV_SHORT  else
                    if aState <= SQCV_LONG   then Result := SQCV_LONG   else Result := SQCV_NONE ;
    SQCG_JOIN     : if aState <= SQCV_ADD    then Result := SQCV_ADD    else
                    if aState <= SQCV_REMOVE then Result := SQCV_REMOVE else Result := SQCV_NONE ;
    SQCG_ORDER    : case aItem of
                      SQCC_ORDER_KWD_LEN     :
                        if aState <= SQCV_SHORT then Result := SQCV_SHORT else
                        if aState <= SQCV_LONG  then Result := SQCV_LONG  else Result := SQCV_NONE ;
                      SQCC_ORDER_KWD_DEF     :
                        if aState <= SQCV_ADD    then Result := SQCV_ADD    else
                        if aState <= SQCV_REMOVE then Result := SQCV_REMOVE else Result := SQCV_NONE ;
                    end;
  end;
end;

{ returns converter default value }
function  SqlConvertDefValue( aGroup, aItem: Integer ): Integer;
begin
  Result := SQCV_NONE;

  case aGroup of
    SQCG_CASES    : case aItem of
                      SQCC_CASE_KEYWORD      : Result := SQCV_UPPER;
                      SQCC_CASE_TABLE        : Result := SQCV_NONE;
                      SQCC_CASE_TABLE_ALIAS  : Result := SQCV_UPPER;
                      SQCC_CASE_COLUMN       : Result := SQCV_NONE;
                      SQCC_CASE_COLUMN_ALIAS : Result := SQCV_UPPER;
                      SQCC_CASE_COLUMN_QUOTE : Result := SQCV_NONE;
                      SQCC_CASE_PARAM        : Result := SQCV_NONE;
                      SQCC_CASE_FUNC         : Result := SQCV_NONE;
                      SQCC_CASE_IDENT        : Result := SQCV_NONE;
                    end;
    SQCG_KEYWORD  : case aItem of
                      SQCC_KWD_AS_TABLES     : Result := SQCV_ADD;
                      SQCC_KWD_AS_COLUMNS    : Result := SQCV_ADD;
                    end;
    SQCG_DATA     : case aItem of
                      SQCC_DATA_INT          : Result := SQCV_NONE;
                    end;
    SQCG_JOIN     : case aItem of
                      SQCC_JOIN_INNER        : Result := SQCV_REMOVE;
                      SQCC_JOIN_OUTER        : Result := SQCV_REMOVE;
                      SQCC_JOIN_ON_LEFT      : Result := SQCV_ADD;
                    end;
    SQCG_ORDER    : case aItem of
                      SQCC_ORDER_KWD_LEN     : Result := SQCV_SHORT;
                      SQCC_ORDER_KWD_DEF     : Result := SQCV_REMOVE;
                    end;
  end;
end;

{ returns converter name }
function  SqlConvertName( aGroup, aItem: Integer ): String;
begin
  Result := '';

  case aGroup of
    SQCG_CASES    : case aItem of
                      SQCC_NONE              : Result := 'Cases';
                      SQCC_CASE_KEYWORD      : Result := 'Keywords';
                      SQCC_CASE_TABLE        : Result := 'Table names';
                      SQCC_CASE_TABLE_ALIAS  : Result := 'Table aliases';
                      SQCC_CASE_COLUMN       : Result := 'Column names';
                      SQCC_CASE_COLUMN_ALIAS : Result := 'Column aliases';
                      SQCC_CASE_COLUMN_QUOTE : Result := 'Column quoted aliases';
                      SQCC_CASE_PARAM        : Result := 'Parameters';
                      SQCC_CASE_FUNC         : Result := 'Functions';
                      SQCC_CASE_IDENT        : Result := 'Identifiers';
                    end;
    SQCG_KEYWORD  : case aItem of
                      SQCC_NONE              : Result := 'Keywords';
                      SQCC_KWD_AS_TABLES     : Result := 'AS for table aliases';
                      SQCC_KWD_AS_COLUMNS    : Result := 'AS for column aliases';
                    end;
    SQCG_DATA     : case aItem of
                      SQCC_NONE              : Result := 'Datatypes';
                      SQCC_DATA_INT          : Result := 'Integer';
                    end;
    SQCG_JOIN     : case aItem of
                      SQCC_NONE              : Result := 'FROM / JOIN';
                      SQCC_JOIN_INNER        : Result := 'INNER keyword';
                      SQCC_JOIN_OUTER        : Result := 'OUTER keyword';
                      SQCC_JOIN_ON_LEFT      : Result := 'ON condition left side refs';
                    end;
    SQCG_ORDER    : case aItem of
                      SQCC_NONE              : Result := 'ORDER BY';
                      SQCC_ORDER_KWD_LEN     : Result := 'Keywords length';
                      SQCC_ORDER_KWD_DEF     : Result := 'Default keywords';
                    end;
  end;
end;

{ executes converter }
procedure SqlConvertExecute( aGroup, aItem, aState: Integer; aNode: TGtSqlNode ); overload;
begin
  case aGroup of
    SQCG_CASES    : case aItem of
                      SQCC_CASE_KEYWORD      : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseKeyword_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseKeyword_Lower(aNode);
                                               end;
                      SQCC_CASE_TABLE        : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseTableName_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseTableName_Lower(aNode);
                                               end;
                      SQCC_CASE_TABLE_ALIAS  : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseTableAlias_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseTableAlias_Lower(aNode);
                                               end;
                      SQCC_CASE_COLUMN       : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseColumnName_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseColumnName_Lower(aNode);
                                               end;
                      SQCC_CASE_COLUMN_ALIAS : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseColumnAlias_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseColumnAlias_Lower(aNode);
                                               end;
                      SQCC_CASE_COLUMN_QUOTE : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseColumnQuotedAlias_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseColumnQuotedAlias_Lower(aNode);
                                               end;
                      SQCC_CASE_PARAM        : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseParam_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseParam_Lower(aNode);
                                               end;
                      SQCC_CASE_FUNC         : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseFunc_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseFunc_Lower(aNode);
                                               end;
                      SQCC_CASE_IDENT        : case aState of
                                                 SQCV_UPPER  : SqlToysConvert_CaseIdentifier_Upper(aNode);
                                                 SQCV_LOWER  : SqlToysConvert_CaseIdentifier_Lower(aNode);
                                               end;
                    end;
    SQCG_KEYWORD  : case aItem of
                      SQCC_KWD_AS_TABLES     : case aState of
                                                 SQCV_ADD    : SqlToysConvert_TableAlias_AddKeyword_AS(aNode);
                                                 SQCV_REMOVE : SqlToysConvert_TableAlias_RemoveKeyword_AS(aNode);
                                               end;
                      SQCC_KWD_AS_COLUMNS    : case aState of
                                                 SQCV_ADD    : SqlToysConvert_ExprAlias_AddKeyword_AS(aNode);
                                                 SQCV_REMOVE : SqlToysConvert_ExprAlias_RemoveKeyword_AS(aNode);
                                               end;
                    end;
    SQCG_DATA     : case aItem of
                      SQCC_DATA_INT          : case aState of
                                                 SQCV_SHORT  : SqlToysConvert_DataType_IntegerToInt(aNode);
                                                 SQCV_LONG   : SqlToysConvert_DataType_IntToInteger(aNode);
                                               end;
                    end;
    SQCG_JOIN     : case aItem of
                      SQCC_JOIN_INNER        : case aState of
                                                 SQCV_ADD    : SqlToysConvert_Joins_AddInner(aNode);
                                                 SQCV_REMOVE : SqlToysConvert_Joins_RemoveInner(aNode);
                                               end;
                      SQCC_JOIN_OUTER        : case aState of
                                                 SQCV_ADD    : SqlToysConvert_Joins_AddOuter(aNode);
                                                 SQCV_REMOVE : SqlToysConvert_Joins_RemoveOuter(aNode);
                                               end;
                      SQCC_JOIN_ON_LEFT      : case aState of
                                                 SQCV_ADD    : SqlToysConvert_JoinCond_RefToLeft(aNode);
                                               end;
                    end;
    SQCG_ORDER    : case aItem of
                      SQCC_ORDER_KWD_LEN     : case aState of
                                                 SQCV_SHORT  : SqlToysConvert_SortOrder_ShortKeywords(aNode);
                                                 SQCV_LONG   : SqlToysConvert_SortOrder_LongKeywords(aNode);
                                               end;
                      SQCC_ORDER_KWD_DEF     : case aState of
                                                 SQCV_ADD    : SqlToysConvert_SortOrder_AddDefaultKeywords(aNode);
                                                 SQCV_REMOVE : SqlToysConvert_SortOrder_RemoveDefaultKeywords(aNode);
                      end;
                    end;
  end;
end;

{ execute all converters }
procedure SqlConvertExecuteAll( aNode: TGtSqlNode );
var Group, Item: Integer;
begin
  for Group := 1 to 99 do
    for Item := 1 to 99 do
      SqlConvertExecute( Group, Item, SqlConvertGetValue( Group, Item ), aNode );
end;

end.

