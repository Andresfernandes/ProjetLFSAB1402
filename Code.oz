local 
   Dossier = {Property.condGet cwdir '/Users/andres/Documents/University/SINF/SINF12BA/Quadrimestre 1/Informatique 2 (LFSAB1402)/Projet 2017'} % Unix example
   SnakeLib
%-------------------%
   Next
   DecodeStrategy
% Width and height of the grid
% (1 <= x <= W=22, 1 <= y <= H=22)
   W = 22
   H = 22
%-------------------%
   Options
in
   [SnakeLib] = {Link [Dossier#'/'#'ProjectLib.ozf']} 
   {Browse SnakeLib.play}
%%%%%%%%%%%%%%%%%%%%%%%%
%        CODE          %
%%%%%%%%%%%%%%%%%%%%%%%%

   local
%---------------------------------------------%
%-------------------EFFECTS-------------------%
%---------------------------------------------%
%------------GROW-----------%
      fun {Grow SnakePositions}
	 case SnakePositions.1.to
	 of north then {AddHeadNorth SnakePositions}
	 [] south then {AddHeadSouth SnakePositions}
	 [] east then {AddHeadEast SnakePositions}
	 [] west then {AddHeadWest SnakePositions}
	 end
      end
%-----------REVERT----------%
      fun {Revert SnakePositions}
	 fun {RevertAcc SnakePositions Resultat}
	    case SnakePositions of nil then Resultat
	    [] H|T then
	       if H.to == north then  {RevertAcc T pos(x:H.x y:H.y to:south)|Resultat}
	       elseif  H.to == south then {RevertAcc T pos(x:H.x y:H.y to:north)|Resultat}
	       elseif  H.to == east then {RevertAcc T pos(x:H.x y:H.y to:west)|Resultat}
	       else {RevertAcc T pos(x:H.x y:H.y to:east)|Resultat}
	       end
	    end
	 end
      in
	 {RevertAcc SnakePositions nil}
      end
%---------TELEPORT---------%
      fun {Teleport Snake Xtarget Ytarget}
	 {AdjoinAt Snake positions {AdjoinAt {AdjoinAt Snake.positions.1 x Xtarget} y Ytarget}|Snake.positions.2}.positions
      end
%---------SHRINK---------%
      fun {Shrink SnakePositions}
	 case SnakePositions.1.to
	 of north then {DeleteTail SnakePositions}
	 [] south then {DeleteTail SnakePositions}
	 [] east then {DeleteTail SnakePositions}
	 [] west then {DeleteTail SnakePositions}
	 end
      end
%---------------------------------------------%
%--------------FOR DECODESTRATEGY-------------%
%---------------------------------------------%
      fun {Ajout L1 L2}
	 case L1 of nil then L2
	 [] H|T then H|{Append T L2}
	 end
      end
%---------------------------------------------%
%-------------------MOVEMENT------------------%
%---------------------------------------------%
%---------DELETE TAIL---------%
      fun{DeleteTail SnakePositions}
	 case SnakePositions of H|T then
	    if T \= nil then H|{DeleteTail T}
	    else nil
	    end
	 else nil
	 end
      end
%---------ADD HEAD---------%
%------TO EAST-------%
      fun {AddHeadEast SnakePositions}
	 local X in
	    X = l(x:(SnakePositions.1.x)+1 y:SnakePositions.1.y to:east)
	    X|SnakePositions
	 end
      end
%------TO WEST-------%
      fun {AddHeadWest SnakePositions}
	 local X in
	    X = l(x:(SnakePositions.1.x)-1 y:SnakePositions.1.y to:west)
	    X|SnakePositions
	 end
      end
%------TO NORTH------%
      fun {AddHeadNorth SnakePositions}
	 local X in
	    X = l(x:SnakePositions.1.x y:(SnakePositions.1.y)-1 to:north)
	    X|SnakePositions
	 end
      end
%------TO SOUTH------%
      fun {AddHeadSouth SnakePositions}
	 local X in
	    X = l(x:SnakePositions.1.x y:(SnakePositions.1.y)+1 to:south)
	    X|SnakePositions
	 end
      end
%---------------------------------------------%
%----------------MAIN FUNCTIONS---------------%
%---------------------------------------------%
   in
      %------------NEXT-----------%
      fun {Next Snake Instruction}
	 
	 case Snake.effects of nil then
	    %--------- Instruction Cases ----------%
	    case Instruction
	     %------ Right
	    of turn(right) then
	       case Snake.positions.1.to
	       of north then snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] east then snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] south then snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] west then snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       end
	     %------ Left
	    [] turn(left) then
	       case Snake.positions.1.to
	       of north then snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] east then snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] south then snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] west then snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       end
	     %------ Forward
	    [] forward then
	       case Snake.positions.1.to
	       of north then snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] east then snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] south then snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       [] west then snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       end
	    end
	    %--------- Effects Cases ----------%
	 [] H|T then
	    case H
	    of grow then snake(team:Snake.team name:Snake.name positions:{Grow Snake.positions} effects:T strategy:Snake.strategy bombing:Snake.bombing)
	    [] revert then snake(team:Snake.team name:Snake.name positions:{Revert Snake.positions} effects:T strategy:Snake.strategy bombing:Snake.bombing)
	    [] shrink then snake(team:Snake.team name:Snake.name positions:{Shrink Snake.positions} effects:T strategy:Snake.strategy bombing:Snake.bombing)
	    [] teleport(x:W y:L) then snake(team:Snake.team name:Snake.name positions:{Teleport Snake W L} effects:T strategy:Snake.strategy bombing:Snake.bombing)
	    end
	 end
      end
      %------------DECODE STRATEGY-----------%
      fun {DecodeStrategy Strategy}
	 case Strategy of nil then nil
	 [] forward|T then fun {$ Snake}{Next Snake forward} end|{DecodeStrategy T}
	 [] turn(left)|T then fun {$ Snake}{Next Snake turn(left)} end|{DecodeStrategy T}
	 [] turn(right)|T then fun {$ Snake}{Next Snake turn(right)} end|{DecodeStrategy T}
	 [] repeat(L times:X)|T then
	    local Repeat in
	       fun {Repeat A X}
		  if X==0 then {DecodeStrategy T}
		  else {Ajout {DecodeStrategy A} {Repeat A X-1}}
		  end
	       end
	       {Repeat L X}
	    end
	 end
      end
%---------------------------------------------%
%-------------------OPTIONS-------------------%
%---------------------------------------------%
      Options = options(scenario:'scenario.oz' debug: true frameRate: 0)
   end
%%%%%%%%%%%
% The end %
%%%%%%%%%%%
   local R = {SnakeLib.play Dossier#'/'#Options.scenario Next DecodeStrategy Options} in
      {Browse R}
   end
end
