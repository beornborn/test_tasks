//@flow
import { combineReducers } from 'redux'
import { reducer as formReducer } from 'redux-form'
import app from 'reducers/App'
import ui from 'reducers/Ui'
import data from 'reducers/Data'

const RootReducer = combineReducers({
  app,
  data,
  ui,
  form: formReducer
})

export default RootReducer
