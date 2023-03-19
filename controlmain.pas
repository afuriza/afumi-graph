unit ControlMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Menus, ControlGraph, TASeries, ControlFindSquig, ControlTargetGenerator;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    Button1: TButton;
    ColorButton1: TColorButton;
    ColorDialog1: TColorDialog;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbName: TLabel;
    lbAuthor: TLabel;
    lvProducts: TListView;
    AppMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    miTools: TMenuItem;
    miTargetGenerator: TMenuItem;
    miDelete: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    mnGraph: TPopupMenu;
    pnGraph: TPanel;
    mnTitles: TPopupMenu;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure ColorButton1Click(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure ColorDialog1Close(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure lvProductsClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure miTargetGeneratorClick(Sender: TObject);
  private

  public
    procedure ParseText(ASource, ATitle, AAuthor: string);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  mnGraph.PopUp();
end;

procedure TfrmMain.ColorButton1Click(Sender: TObject);
begin

end;

procedure TfrmMain.ColorButton1ColorChanged(Sender: TObject);
begin

end;

procedure TfrmMain.ColorDialog1Close(Sender: TObject);
begin
  if lvProducts.Selected <> nil then
  begin
    TLineSeries(frmGraph.GraphChart.Series[lvProducts.Selected.Index])
      .SeriesColor := ColorDialog1.Color;
    frmGraph.GraphChart.Refresh;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmGraph.BorderStyle := bsNone;
  frmGraph.Parent := pnGraph;
  frmGraph.Align := alClient;
  frmGraph.Show;
end;

procedure TfrmMain.Image1Click(Sender: TObject);
begin

end;

procedure TfrmMain.lvProductsClick(Sender: TObject);
begin
  if lvProducts.Selected <> nil then
  begin
    ColorButton1.ButtonColor := TLineSeries(frmGraph.GraphChart.Series[lvProducts.Selected.Index])
      .SeriesColor;
    lbName.Caption := lvProducts.Selected.Caption;
    lbAuthor.Caption := lvProducts.Selected.SubItems[0];
  end;
end;

procedure TfrmMain.ParseText(ASource, ATitle, AAuthor: string);
var
  OriginText, ParsedText: TStringList;
  i: Integer;
  StartParse: Boolean;
  ListItem: TListItem;
  NewSeries: TLineSeries;
  AlignToTarget: Double;
  CurrentFreqTarget, CurrentAudibleTarget: integer;
begin
  CurrentFreqTarget := 750;
  CurrentAudibleTarget := 60;
  FormatSettings.DecimalSeparator := '.';
  ParsedText := TStringList.Create;
  OriginText := TStringList.Create;
  ParsedText.Delimiter := #9;
  ParsedText.StrictDelimiter := False;
  ParsedText.QuoteChar := '"';

  OriginText.Text := ASource;
  NewSeries := TLineSeries.Create(nil);
  NewSeries.Assign(frmGraph.dummySeries);
  NewSeries.Title := ATitle + ' (' + AAuthor + ')';
  frmGraph.GraphChart.AddSeries(NewSeries);
  ListItem := lvProducts.Items.Add;
  ListItem.Caption := ExtractFileName(ATitle);
  ListItem.SubItems.Add(AAuthor);

  StartParse := False;

  for i := 0 to OriginText.Count -1 do
  begin
    if StartParse then
    begin
      ParsedText.DelimitedText := OriginText[i];
      if (ParsedText[0].ToDouble > CurrentFreqTarget - 20) and
        (ParsedText[0].ToDouble < CurrentFreqTarget + 20) then
      begin
        //if ParsedText[1].ToDouble > CurrentAudibleTarget then
        AlignToTarget := CurrentAudibleTarget - ParsedText[1].ToDouble;
      end;

    end;


    if (OriginText[i].Contains('Freq(Hz)') and
      OriginText[i].Contains('SPL(dB)') ) then
      StartParse := True;


  end;

  StartParse := False;

  for i := 0 to OriginText.Count -1 do
  begin
    if StartParse then
    begin
      ParsedText.DelimitedText := OriginText[i];
      //if ParsedText[0].ToDouble < 1000 then
      NewSeries.AddXY(ParsedText[0].ToDouble, ParsedText[1].ToDouble + AlignToTarget);
      //frmGraph.Chart1LineSeries2.AddXY(ParsedText[0].ToDouble, ParsedText[1].ToDouble);
    end;


    if (OriginText[i].Contains('Freq(Hz)') and
      OriginText[i].Contains('SPL(dB)')) then
      StartParse := True;


  end;
  FreeAndNil(ParsedText);
  FreeAndNil(OriginText);
end;

procedure TfrmMain.MenuItem1Click(Sender: TObject);
var
  OriginText: TStringList;
begin
  OriginText := TStringList.Create;
  if OpenDialog1.Execute then
  begin
    OriginText.LoadFromFile(OpenDialog1.FileName);
    ParseText(OriginText.Text, ExtractFileName(OpenDialog1.FileName), 'N/A (File)');
  end;
  FreeAndNil(OriginText);
end;

procedure TfrmMain.MenuItem2Click(Sender: TObject);
begin
  frmFindSquig.ShowModal;
end;

procedure TfrmMain.miDeleteClick(Sender: TObject);
begin
  //lvProducts.Items.Ad;
  if lvProducts.Selected <> nil then
  begin
    frmGraph.GraphChart.Series.List.Remove(frmGraph.GraphChart.Series.List[
      lvProducts.Selected.Index]);
    lvProducts.Items.Delete(lvProducts.Selected.Index);
    frmGraph.GraphChart.Refresh;
  end;
end;

procedure TfrmMain.miTargetGeneratorClick(Sender: TObject);
begin
  frmTargetGenerator.Show;
end;

end.

