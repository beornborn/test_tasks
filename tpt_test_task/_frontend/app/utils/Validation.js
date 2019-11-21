//@flow
import { isNil, trim } from 'lodash'

export const validatePresence = (value: string, message: string) =>
  isNil(value) || trim(value) === '' ? message : null
export const validateDateRange = (start: string, end: string, message: string) => {
  return start > end ? message : null
}
export const validateLength = (value: string, length: number, message: string) =>
  value.length >= length ? message : null
export const validateEmailSignature = (email: string) => {
  const notEmail = !/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.test(email)
  if (notEmail) return 'This doesn\'t look like an email to us'
  return null
}
export const validatePassword = (password: string) =>
  password.length < 6 ? 'Password is too short (minimum is 6 characters)' : null
export const validateWorkingMinutes = (working_minutes: string) => {
  const valid = /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(working_minutes)
  if (!valid) return 'Your working hours are not in hh:mm format'
}
