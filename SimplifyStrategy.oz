
declare
fun {RepeatedInstructions List Times}
   if Times < 1 then nil
   else List.1|{RepeatedInstructions List Times-1}
   end 
end

fun {SimplifyStrategy Strategy}
   case Strategy
   of H|T then
      case H
      of repeat(L times:X) then

	 %-------------
	 local P in
	    P = {RepeatedInstructions L X}
	    case P
	    of H|T then H|{SimplifyStrategy T}
	    [] nil then {SimplifyStrategy }
	    end
	 end

	 
	 %--------------

      [] L then H|{SimplifyStrategy T}
      end
   [] nil then nil
   end
end



TestStrategy =  [forward repeat([forward] times:2) turn(right)]

{Browse {SimplifyStrategy TestStrategy}}

   
	       