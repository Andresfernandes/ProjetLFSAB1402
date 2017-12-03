
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
	 {RepeatedInstructions L X}|{SimplifyStrategy T}
      [] L then H|{SimplifyStrategy T}
      end
   [] nil then nil
   end
end



TestStrategy =  [forward turn(right) turn(right) turn(right) forward forward forward turn(right) turn(right) turn(left)
		 repeat([forward] times:30)]

{Browse {SimplifyStrategy TestStrategy}}

   
	       