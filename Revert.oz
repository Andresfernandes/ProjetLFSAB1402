%% FONCTION REVERT
declare
fun {Revert L}
      fun {RevertAcc L R}
         case L of nil then R
         [] H|T then {RevertAcc T H|R}
         end
      end
   in
      {RevertAcc L nil}
end
Pos = [pos(x:11 y:13 to:east) pos(x:10 y:13 to:east) pos(x:9 y:13 to:east)]
{Browse {Revert Pos}}
