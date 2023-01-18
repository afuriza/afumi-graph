unit ControlGraph;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, TAGraph, TASeries,
  TATransformations, TASources, TAGUIConnectorBGRA, TACustomSeries, TADrawUtils,
  TAStyles, TAChartAxisUtils, TACustomSource, Types, TATextElements,
  TAChartUtils, TATools, TALegendPanel;

type

  { TfrmGraph }

  TfrmGraph = class(TForm)
    ChartGUIConnectorBGRA1: TChartGUIConnectorBGRA;
    GraphChart: TChart;
    dummySeries: TLineSeries;
    dummyChart: TChart;
    ChartAxisTransformations1: TChartAxisTransformations;
    ChartAxisTransformations1LogarithmAxisTransform1: TLogarithmAxisTransform;
    ListChartSource1: TListChartSource;
    procedure dummySeriesCustomDrawPointer(ASender: TChartSeries;
      ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
    procedure dummySeriesGetMark(out AFormattedMark: String; AIndex: Integer);
    procedure GraphChartAfterCustomDrawBackWall(ASender: TChart;
      ADrawer: IChartDrawer; const ARect: TRect);
    procedure GraphChartAfterDraw(ASender: TChart; ADrawer: IChartDrawer);
    procedure GraphChartAxisList1GetMarkText(Sender: TObject;
      var AText: String; AMark: Double);
    procedure GraphChartAxisList1MarkToText(var AText: String; AMark: Double);
    procedure GraphChartBeforeCustomDrawBackground(ASender: TChart;
      ADrawer: IChartDrawer; const ARect: TRect; var ADoDefaultDrawing: Boolean
      );
    procedure GraphChartChartTitleGetShape(ASender: TChartTextElement;
      const ABoundingBox: TRect; var APolygon: TPointArray);
    procedure GraphChartClick(Sender: TObject);
    function ListChartSource1Compare(AItem1, AItem2: Pointer): Integer;
  private

  public
  end;

var
  frmGraph: TfrmGraph;

implementation

{$R *.lfm}

{ TfrmGraph }

function TfrmGraph.ListChartSource1Compare(AItem1, AItem2: Pointer): Integer;
begin

end;

procedure TfrmGraph.dummySeriesGetMark(out AFormattedMark: String;
  AIndex: Integer);
begin

end;

procedure TfrmGraph.GraphChartAfterCustomDrawBackWall(ASender: TChart;
  ADrawer: IChartDrawer; const ARect: TRect);
begin

end;

procedure TfrmGraph.GraphChartAfterDraw(ASender: TChart; ADrawer: IChartDrawer);
begin

end;

procedure TfrmGraph.GraphChartAxisList1GetMarkText(Sender: TObject;
  var AText: String; AMark: Double);
begin
  if AMark >= 1000 then
  begin
    AText := FloatToStr(AMark / 1000) + ' kHz';
  end;
end;

procedure TfrmGraph.GraphChartAxisList1MarkToText(var AText: String;
  AMark: Double);
begin
  //if AMark >= 1000 then
  //begin
  //  AText := FloatToStr(AMark / 1000) + ' kHz';
  //end;
end;

procedure TfrmGraph.GraphChartBeforeCustomDrawBackground(ASender: TChart;
  ADrawer: IChartDrawer; const ARect: TRect; var ADoDefaultDrawing: Boolean);
begin

end;

procedure TfrmGraph.GraphChartChartTitleGetShape(ASender: TChartTextElement;
  const ABoundingBox: TRect; var APolygon: TPointArray);
begin

end;

procedure TfrmGraph.GraphChartClick(Sender: TObject);
begin

end;

procedure TfrmGraph.dummySeriesCustomDrawPointer(ASender: TChartSeries;
  ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
begin

end;

end.

