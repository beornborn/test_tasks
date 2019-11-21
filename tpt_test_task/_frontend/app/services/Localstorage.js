//@flow
const setItem = (name: string, value: any) => window.localStorage.setItem(name, JSON.stringify(value))
const getItem = (name: string) => JSON.parse(window.localStorage.getItem(name))

const Localstorage = {
  getAuthToken: () => getItem('authToken'),
  setAuthToken: (authToken: string) => setItem('authToken', authToken),
}

export default Localstorage
