program project;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, tachartbgra, ControlMain,
  ControlGraph, ControlFindSquig, GraphCollection, ControlTargetGenerator
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmGraph, frmGraph);
  Application.CreateForm(TfrmFindSquig, frmFindSquig);
  Application.CreateForm(TfrmTargetGenerator, frmTargetGenerator);
  Application.Run;
end.

