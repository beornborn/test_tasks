//@flow
import 'whatwg-fetch'
import { api } from 'Config'
import type { MethodType } from 'Types'
import Localstorage from 'services/Localstorage'
import querystring from 'querystring'

export function logResponse(response: Object) {
  console.log(response)
  return response
}

export function parseJSON(response: Object) {
  return response.text().then(text => {
    if (text === '') return new Promise((resolve,_reject) => { resolve({}) })

    const json = JSON.parse(text)
    return new Promise((resolve,_reject) => { resolve(json) })
  })
}

function handleResponse(response: Object) {
  return response
    .then(logResponse)
    .then(parseJSON)
    .catch(e => {
      if (e.response) throw e
      console.log(e)
      const error = new Error('Bad Connection')
      error.message = 'Check your internet connection'
      throw error
    })
}

export function apiPostFormData(path: string, files: Array<Object>) {
  const formData = new FormData()
  files.map((file) => formData.append('files[]', file))

  const settings: Object = {
    method: 'POST',
    headers: { 'X-AUTH-TOKEN': Localstorage.getAuthToken() },
    body: formData
  }

  return handleResponse(fetch(`${api.url}${path}`,settings))
}

function request(path: string, payload: Object, method: MethodType) {
  const settings: Object = {
    method,
    headers: {
      'X-AUTH-TOKEN': Localstorage.getAuthToken(),
      'Content-Type': 'application/json'
    }
  }

  if (method !== 'GET') { settings.body = JSON.stringify(payload) }

  return handleResponse(fetch(`${api.url}${path}`,settings))
}

export function apiGet(path: string, payload: Object = {}) {
  console.log(payload)
  const newPath = `${path}?${querystring.stringify(payload)}`
  return request(newPath, {}, 'GET')
}

export function apiPost(path: string, payload: Object = {}) {
  return request(path, payload, 'POST')
}

export function apiPut(path: string, payload: Object = {}) {
  return request(path, payload, 'PUT')
}

export function apiDelete(path: string, payload: Object = {}) {
  return request(path, payload, 'DELETE')
}
