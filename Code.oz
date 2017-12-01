local 
% Vous pouvez remplacer ce chemin par celui du dossier qui contient ProjectLib.ozf
% Please replace this path with your own working directory that contains ProjectLib.ozf
   Dossier = {Property.condGet cwdir '/Users/andres/Documents/University/SINF/SINF12BA/Quadrimestre 1/Informatique 2 (LFSAB1402)/Projet 2017'} % Unix example
% Dossier = {Property.condGet cwdir 'C:\\Users\\Thomas\\Documents\\U'} % Windows example.
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


   in
      fun {Next Snake Instruction}
	 local PositionTete in
	    PositionTete = Snake.positions.1
      
	    if Instruction == turn(right) then

	       if PositionTete.to == north then
	       
		  snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
		     
	       elseif PositionTete.to == east then
	       
		  snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	       elseif PositionTete.to == south then
	       
		  snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	 
	       else

		  snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	       end

	    elseif Instruction == turn(left) then
	    
	       if PositionTete.to == north then

		  snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	      
	       elseif PositionTete.to == east then

		  snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	       elseif PositionTete.to == south then

		  snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	       else

		  snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)

	       end
      
	    else
	    
	       if PositionTete.to == north then

		  snake(team:Snake.team name:Snake.name positions:{AddHeadNorth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	       elseif PositionTete.to == east then

		  snake(team:Snake.team name:Snake.name positions:{AddHeadEast {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	      
	       elseif PositionTete.to == south then

		  snake(team:Snake.team name:Snake.name positions:{AddHeadSouth {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	   
	       else 

		  snake(team:Snake.team name:Snake.name positions:{AddHeadWest {DeleteTail Snake.positions}} effects:Snake.effects strategy:Snake.strategy bombing:Snake.bombing)
	       
	       end
	
	 end
	 end
	 end
      
      fun {DecodeStrategy Strategy}
	 
	 [fun{$ Snake}
	     Snake

	     
	  end]
      end

% Options
      Options = options(
% Fichier contenant le scénario (depuis Dossier)
% Path of the scenario (relative to Dossier)
		   scenario:'scenario_test_moves.oz'
% Visualisation de la partie
% Graphical mode
		   debug: true
% Instants par seconde, 0 spécifie une exécution pas à pas. (appuyer sur 'Espace' fait avancer le jeu d'un pas)
% Steps per second, 0 for step by step. (press 'Space' to go one step further)
		   frameRate: 1)
   end

%%%%%%%%%%%
% The end %
%%%%%%%%%%%
   local R = {SnakeLib.play Dossier#'/'#Options.scenario Next DecodeStrategy Options} in
      {Browse R}
   end
end
