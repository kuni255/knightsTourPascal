program knightsTour;

uses Classes, SysUtils, ktUtils;

type TAInteger = array of integer;

var
  massList, passMass : TList;
  curMass : TPoint;
  i : Integer;
  solved : boolean;

const
  requiredNumParam = 2;

begin
  if ParamCount <> requiredNumParam then begin
    WriteLn(errOutput, format('usage: %s board-num-col board-num-row', [paramStr(0)]));
    exit;
  end;
  bordNumCol := StrToInt(paramStr(1));
  bordNumRow := StrToInt(paramStr(2));

  solved := False;
  massList := TList.Create;
  passMass := TList.Create;
  curMass := Point(1, 1);
  passMass.Add(Pointer(Point(curMass.X, curMass.Y)));
  while true do begin
    getMoveableMassList(curMass.X, curMass.Y, passMass, massList);
    //dumpMass(massList);
    if massList.count = 0 then begin
      WriteLn('Cannot solve');
      break;
    end;

    // decide next mass
    i := Random(massList.count);
    curMass := Point(TPoint(massList[i]).X, TPoint(massList[i]).Y);
    passMass.Add(Pointer(curMass));
    if passMass.count = (bordNumRow*bordNumCol) then begin
      solved := True;
      break;
    end;
  end;
  if solved then begin
    WriteLn('colNum rowNum');
    for i := 0 to passMass.count-1 do begin
      WriteLn(format('%2d %2d', [TPoint(passMass[i]).X, TPoint(passMass[i]).Y]));
    end;
  end;
  
  FreeAndNil(passMass);
  FreeAndNil(massList);
end.
