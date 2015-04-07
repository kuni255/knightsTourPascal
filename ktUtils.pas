unit ktUtils;

interface

uses classes, SysUtils;

var
  bordNumRow, bordNumCol : Integer;

procedure getMoveableMassList(col, row : Integer; passMass, massList : TList);
procedure dumpMass(mass : TList);

implementation

var
  massIncrement : array[0..7] of TPoint;


procedure dumpMass(mass : TList);
var
  i : Integer;
begin
  for i:= 0 to mass.count-1 do begin
    WriteLn(format('(%d, %d)', [ TPoint(mass[i]).X, TPoint(mass[i]).Y ]));
  end;
end;

procedure setInnerBoardMass(col, row : Integer; massList : TList);
var
  i : Integer;
  curPoint : TPoint;
begin
  for i:=0 to 7 do begin
    curPoint.X := col+massIncrement[i].X;
    curPoint.Y := row+massIncrement[i].Y;
    if (curPoint.X>bordNumCol) or (curPoint.Y>bordNumRow) then continue;
    if (curPoint.X<=0) or (curPoint.Y<=0) then continue;
    massList.Add(pointer(curPoint));
  end;
end;

// heavy process
procedure rmAlreadyPassed(passMass, massList: TList);
var
  i, j : Integer;
  removed : Boolean;
begin
  removed := False;
  j := 0;
  while true do begin
    if j=massList.count then break;
    for i:=0 to passMass.count-1 do begin
      if PointsEqual(TPoint(passMass[i]), TPoint(massList[j])) then begin
        massList.delete(j);
        removed := true;
        break;
      end;
    end;
    if removed then begin
      removed := False;
    end else begin
      Inc(j);
    end;
  end;
end;

{
  description: you can get moveble mass list from current knights position
  arguments:
    col[in] column number of current position
    row[in] row number of current position
    track[in] list of mass knights already passed
    massList[out] you can get moveable mass list. you can get empty list.
    If knights cannot move any mass from current position.
}
procedure getMoveableMassList(col, row : Integer; passMass, massList : TList);
var
  curPoint : TPoint;
begin
  if(not Assigned(massList)) then exit;
  massList.clear;
  setInnerBoardMass(col, row, massList);
  rmAlreadyPassed(passMass, massList);
end;

initialization
  massIncrement[0].X :=  1; // col
  massIncrement[0].Y := -2; // row
  massIncrement[1].X :=  2;
  massIncrement[1].Y := -1;
  massIncrement[2].X :=  2;
  massIncrement[2].Y :=  1;
  massIncrement[3].X :=  1;
  massIncrement[3].Y :=  2;
  massIncrement[4].X := -1;
  massIncrement[4].Y :=  2;
  massIncrement[5].X := -2;
  massIncrement[5].Y :=  1;
  massIncrement[6].X := -2;
  massIncrement[6].Y := -1;
  massIncrement[7].X := -1;
  massIncrement[7].Y := -2;

end.
