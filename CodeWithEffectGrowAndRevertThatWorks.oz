local 
% Vous pouvez remplacer ce chemin par celui du dossier qui contient ProjectLib.ozf
% Please replace this path with your own working directory that contains ProjectLib.ozf
  % Dossier = {Property.condGet cwdir '/Users/andres/Documents/University/SINF/SINF12BA/Quadrimestre 1/Informatique 2 (LFSAB1402)/Projet 2017'} % Unix example
 Dossier = {Property.condGet cwdir 'C:\\Users\\Karolina\\Desktop\\Q3\\INFO 2\\ProjetInfo'} % Windows example.
   SnakeLib

% Les deux fonctions que vous devez implémenter
% The two function you have to implement
   Next
   DecodeStrategy
% Hauteur et largeur de la grille
% Width and height of the grid
% (1 <= x <= W=22, 1 <= y <= H=22)
   W = 22
   H = 22

   Options
in
% Merci de conserver cette ligne telle qu'elle.
% Please do NOT change this line.
   [SnakeLib] = {Link [Dossier#'/'#'ProjectLib.ozf']}
   {Browse SnakeLib.play}

%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here  %
% Votre code vient ici %
%%%%%%%%%%%%%%%%%%%%%%%%

   local
% Déclarez vos functions ici
% Declare your functions here

      fun {Grow SnakePositions} %WORKING
	 if {HeadNorth SnakePositions.1.to} then {AddHeadNorth SnakePositions}
	 elseif {HeadSouth SnakePositions.1.to} then {AddHeadSouth SnakePositions}
	 elseif  {HeadEast SnakePositions.1.to} then {AddHeadEast SnakePositions}
	 else {AddHeadWest SnakePositions.1.to}
	 end

      end
%-------------------------
%     fun {CheckBonus X Y}
%	 if X.1==Y.position then
%	    case Y.effect of nil then X
%	    else
%	       local SnakePositions in
%		  if Y.effect==grow then {Grow SnakePositions}
%		  elseif Y.effect==revert then 2 %Not yet {Revert Snake}
%		  else 3 %Not yet {Teleport Snake}
%		  end
%	       end
%	    end
%	 else nil
%	 end
%     end
%--------------------
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
%--------------------
		fun{Teleport SnakePositions Xtarget Ytarget} %Xtarget/Ytarget se recuperent de l'effet teleport avec Snake.effects.x ou .y
	 fun {TeleportAcc SnakePositions Xtarget Ytarget Resultat}
	    case SnakePositions of nil then Resultat
	    [] H|T then
	       if H.to == north then {TeleportAcc T Xtarget Ytarget pos(x:Xtarget y:H.Ytarget-1 to:H.to)|Resultat}
	       elseif H.to == south then {TeleportAcc T Xtarget Ytarget pos(x:Xtarget y:H.Ytarget+1 to:H.to)|Resultat}
	       elseif H.to == east then {TeleportAcc T Xtarget Ytarget pos(x:Xtarget+1 y:H.Ytarget to:H.to)|Resultat}
	       else {TeleportAcc T Xtarget Ytarget pos(x:Xtarget-1 y:H.Ytarget to:H.to)|Resultat}
	       end
	    end
	 end
      in
	 {TeleportAcc SnakePositions Xtarget Ytarget nil}
      end
%--------------------
      fun {RepeatedInstructions List Times}
	 if Times < 1 then nil
	 else List.1|{RepeatedInstructions List Times-1}
	 end 
      end
%-----------------------%
      fun {DecomposeStrategy L}
	 local
	    fun {DecomposeStrategyAux A End}
	       case A
	       of nil then End
	       [] H|T then {DecomposeStrategyAux H {DecomposeStrategyAux T End}}
	       else A|End
	       end
	    end
	 in
	    {DecomposeStrategyAux L nil}
	 end
      end
%-----------------------%
      fun {SimplifyStrategy Strategy}
	 case Strategy
	 of H|T then
	    case H
	    of repeat(L times:X) then
	       {RepeatedInstructions L X}|{SimplifyStrategy T}
	    [] L then H|{SimplifyStrategy T}
	    end
	 [] nil then nil
	 end
      end
%---------------------
      fun{DeleteTail SnakePositions}
	 case SnakePositions of H|T then
	    if T \= nil then H|{DeleteTail T}
	    else nil
	    end
	 else nil
	 end
      end
%----------------------
      fun {AddHeadEast SnakePositions}
	 local X in
	    X = l(x:(SnakePositions.1.x)+1 y:SnakePositions.1.y to:east)
	    X|SnakePositions
	 end
      end
%----------------------
      fun {AddHeadWest SnakePositions}
	 local X in
	    X = l(x:(SnakePositions.1.x)-1 y:SnakePositions.1.y to:west)
	    X|SnakePositions
	 end
      end
%----------------------
      fun {AddHeadNorth SnakePositions}
	 local X in
	    X = l(x:SnakePositions.1.x y:(SnakePositions.1.y)-1 to:north)
	    X|SnakePositions
	 end
      end
%----------------------
      fun {AddHeadSouth SnakePositions}
	 local X in
	    X = l(x:SnakePositions.1.x y:(SnakePositions.1.y)+1 to:south)
	    X|SnakePositions
	 end
      end
%----------------------
      fun {RightInstruction InputInstruction}
	 if InputInstruction == turn(right) then true
	 else false
	 end
      end
      fun {LeftInstruction InputInstruction}
	 if InputInstruction == turn(left) then true
	 else false
	 end
      end
      fun {ForwardInstruction InputInstruction}
	 if InputInstruction == forward then true
	 else false
	 end
      end
%----------------------
      fun {HeadNorth HeadDirection}
	 if HeadDirection == north then true
	 else false
	 end
      end
      fun {HeadSouth HeadDirection}
	 if HeadDirection == south then true
	 else false
	 end
      end
      fun {HeadEast HeadDirection}
	 if HeadDirection == east then true
	 else false
	 end
      end
      fun {HeadWest HeadDirection}
	 if HeadDirection == west then true
	 else false
	 end
      end
%----------------------
   in
      fun {Next Snake Instruction}
	 case Snake.effects of nil then
	 if {RightInstruction Instruction} then
	 
	    if {HeadNorth Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
		     
	    elseif {HeadEast Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	    elseif {HeadSouth Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
		  
	    else snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	    end
	    %----
	 elseif {LeftInstruction Instruction} then
	    
	    if {HeadNorth Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)

	    elseif {HeadEast Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	    elseif {HeadSouth Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	    else snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	    end
	  %----  
	 else
	    
	    if {HeadNorth Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	    elseif {HeadEast Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	      
	    elseif {HeadSouth Snake.positions.1.to} then
	       snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	   
	    else 
	       snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	    end
	
	 end
	 []H|T then
	    if H==grow then
	       snake(team:Snake.team name:Snake.name positions:{Grow Snake.positions} effects:T strategy:Snake.strategy bombing:Snake.bombing)
	    elseif H==revert then
	       snake(team:Snake.team name:Snake.name positions:{Revert Snake.positions} effects:T strategy:Snake.strategy bombing:Snake.bombing)
	    else  snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:T strategy:Snake.strategy bombing:Snake.bombing)
	    end
	    
	 end
	 
      end
%----------------------------------------%
      fun {DecodeStrategy Strategy}
	 local StrategyList in
	    StrategyList = {DecomposeStrategy {SimplifyStrategy Strategy}}
	    case StrategyList
	    of nil then nil 
	    [] H|T then (fun{$ Snake}{Next Snake H}end)|{DecodeStrategy T}
	    end
	 end
      end
% Options
      Options = options(
% Fichier contenant le scénario (depuis Dossier)
% Path of the scenario (relative to Dossier)
		   scenario:'scenario_test_grow.oz'
% Visualisation de la partie
% Graphical mode
		   debug: true
% Instants par seconde, 0 spécifie une exécution pas à pas. (appuyer sur 'Espace' fait avancer le jeu d'un pas)
% Steps per second, 0 for step by step. (press 'Space' to go one step further)
		   frameRate: 0)
   end

%%%%%%%%%%%
% The end %
%%%%%%%%%%%
   local R = {SnakeLib.play Dossier#'/'#Options.scenario Next DecodeStrategy Options} in
      {Browse R}
   end
end
