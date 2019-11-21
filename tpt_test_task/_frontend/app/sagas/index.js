//@flow
import { all } from 'redux-saga/effects'
import Authenticate from 'sagas/auth/Authenticate'
import Signin from 'sagas/auth/Signin'
import Signup from 'sagas/auth/Signup'
import Logout from 'sagas/auth/Logout'

import FetchUsers from 'sagas/users/FetchUsers'
import FetchUser from 'sagas/users/FetchUser'
import DeleteUser from 'sagas/users/DeleteUser'
import CreateUser from 'sagas/users/CreateUser'
import UpdateUser from 'sagas/users/UpdateUser'

import FetchActivities from 'sagas/activities/FetchActivities'
import FetchActivity from 'sagas/activities/FetchActivity'
import DeleteActivity from 'sagas/activities/DeleteActivity'
import CreateActivity from 'sagas/activities/CreateActivity'
import UpdateActivity from 'sagas/activities/UpdateActivity'

export default function* rootSaga(): Generator<any,any,any> {
  yield all([
    Authenticate(),
    Signin(),
    Signup(),
    Logout(),

    FetchUsers(),
    FetchUser(),
    DeleteUser(),
    CreateUser(),
    UpdateUser(),

    FetchActivities(),
    FetchActivity(),
    DeleteActivity(),
    CreateActivity(),
    UpdateActivity(),
  ])
}
