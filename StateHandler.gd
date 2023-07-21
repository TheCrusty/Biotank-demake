extends Node2D

enum STATES {IDLE, SEEK, ATTACK, DEATH}
 
var CURRENT_STATE = STATES.IDLE

func change_state(state):
	if CURRENT_STATE == STATES.DEATH:
		return
	if state == STATES.DEATH:
 		$AttackTimer.stop()
		$AttackRange.set_monitoring(false)
	CURRENT_STATE = state
	
func getState():
	return CURRENT_STATE
