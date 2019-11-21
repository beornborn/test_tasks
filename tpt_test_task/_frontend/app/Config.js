//@flow
const serverUrl = process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : 'https://oleg-tracker.herokuapp.com'
export const api = {
  serverUrl,
  url: `${serverUrl}/`,
}

export const routes = {
  users: {
    index: () => `v1/users`,
    me: () => `v1/users/me`,
    delete: (id: number) => `v1/users/${id}`,
    update: (id: number) => `v1/users/${id}`,
    show: (id: number) => `v1/users/${id}`,
  },
  activities: {
    index: () => `v1/activities`,
    create: () => `v1/activities`,
    delete: (id: number) => `v1/activities/${id}`,
    update: (id: number) => `v1/activities/${id}`,
    show: (id: number) => `v1/activities/${id}`,
  },
  auth: {
    signin: () => `v1/login`,
    signup: () => `v1/signup`,
  },
}

const config = { api, routes }
export default config
