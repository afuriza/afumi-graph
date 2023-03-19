unit ControlTargetGenerator;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, TAGraph, ControlGraph;

type

  { TfrmTargetGenerator }

  TfrmTargetGenerator = class(TForm)
    btnEdit1: TButton;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    lvTemplate: TListView;
    lvTemplate1: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    procedure FormCreate(Sender: TObject);
  private

  public
    frmGraph: TfrmGraph;
  end;

var
  frmTargetGenerator: TfrmTargetGenerator;

implementation

{$R *.lfm}

{ TfrmTargetGenerator }

procedure TfrmTargetGenerator.FormCreate(Sender: TObject);
begin
  frmGraph := TfrmGraph.Create(Self);
  frmGraph.Parent := Panel4;
  frmGraph.BorderStyle := bsNone;
  frmGraph.Align := alClient;
  frmGraph.Show;
end;

end.

