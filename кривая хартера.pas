program Krivoi;
 uses GraphABC;
 var
  i: integer;
 procedure Draw(x, y, dx, dy: integer);
var
  turn: array [1..1000] of Boolean;//поворот массива
  a, b, d, t: integer;
  f: Boolean;
  i: integer;
begin
  SetWindowSize(790, 500);//Устанавливаем ширину и высоту графического окна.
  SetWindowCaption('Фракталы. Кривая Дракона');
  f := true;
  for a := 1 to 64 do
  begin
    turn[2 * a - 1] := f;
    f := not f;
    turn[2 * a] := turn[a];
  end;
  b := 0;
  d := 1;
  f := false;//при f ложном
  MoveTo(x, y);
  for a := 1 to 128 do
  begin
    for i := 1 to 127 * 4 do
    begin
      b := b + d; x := x + dx; y := y + dy;
      LineTo(x, y);
      if f and not turn[b] or not f and turn[b] then
      begin
        t := dy;
        dy := -dx;
      end
      else
      begin
        t := -dy;
        dy := dx;
      end;
      dx := t;
    end;
    b := b + d; d := -d;
    f := not f;
    x := x + dx; y := y + dy;
    LineTo(x, y);
    if turn[a] then
    begin
      t := dy;
      dy := -dx;
    end
    else
    begin
      t := -dy;
      dy := dx;
    end;
    dx := t;
  end;
end;
 
var
  x, y, dx, dy, k: integer;
 
procedure text;
begin
  textout(10, 100, 'Left - влево');
  textout(10, 120, 'Right - вправо');
  textout(10, 140, 'Up - вверх');
  textout(10, 160, 'Down - вниз');
  textout(10, 180, 'z - увеличение');
  textout(10, 200, 'x - уменьшение');
  textout(10, 220, 'a - фрактал');
  textout(10, 240, 'd - фрактал');
end;
 
procedure KeyDown(key: integer);//Движ
begin
  i := 0;
  case key of
    VK_Up: begin y := y - 50 end;
    VK_Down: begin y := y + 50 end;
    VK_Left: begin x := x - 50 end;
    VK_Right: begin x := x + 50 end;
    VK_z:
      begin
        i := i + 1;
        x := x + i;
        dx := dx - i;
        dy := dy + i;
        y := y - i;
      end;
    Vk_x:
      begin
        i := i - 1;
        x := x - i;
        dx := dx + i;
        dy := dy - i;
        y := y + i; 
      end;
    vk_a: if i > 0 then i -= 1;
    vk_d: if i < 4 then i += 1;
    vk_F: 
  end; 
  Window.Clear; 
  text;
  draw(x, y, dx, dy);
  redraw;
end;
 
begin
  writeln('Left - влево');
  writeln('Right - вправо');
  writeln('Up - вверх');
  writeln('Down - вниз');
  writeln('z - увеличение');
  writeln('x - уменьшение');
  writeln('a - фрактал');
  writeln('d - фрактал');
  LockDrawing;
  x := 200;
  y := 140;
  dx := 0;
  dy := -4;
  draw(x, y, dx, dy);
  redraw;
  onKeyDown += keydown;
end.