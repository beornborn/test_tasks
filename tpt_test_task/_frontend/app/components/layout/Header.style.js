//@flow
import styled from 'styled-components'
import { palette } from 'Theme'

export const Container = styled.div`
  display: flex;
  flex-direction: horizontal;
  align-items: center;
  border-bottom: 1px solid ${palette.primary};
  padding: 10px 100px 10px 200px;
`
export const LinkText = styled.span`
  color: ${p => p.active ? palette.pacificBlue : palette.primary};
  font-size: 16px;
  margin-left: 30px;
  font-weight: ${p => p.active ? 'bold' : 'normal'};
`
export const Spacer = styled.div`
  display: flex;
  flex-grow: 1;
`
export const Name = styled.div`
  margin-right: 40px;
  font-size: 16px;
  margin-left: 20px;
`
