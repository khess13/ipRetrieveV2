import { LightningElement, api } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
import getClientIpAddress from '@salesforce/apex/IpAddressController.getClientIpAddress';
import logError from '@salesforce/apex/ErrorLoggerCls.logError';

export default class IpAddressRetrieve extends LightningElement {
    @api ipAddr;

    async connectedCallback() {
        try {
            const ip = await getClientIpAddress();
            if (ip) {
                this.ipAddr = ip;
                this.dispatchEvent(new FlowAttributeChangeEvent('ipAddr', this.ipAddr));
            } else {
                this.logErrorToServer('No IP returned from server');
            }
        } catch (error) {
            this.logErrorToServer('connectedCallback error: ' + error.message);
        }
    }

    async logErrorToServer(errorMessage) {
        try {
            await logError({ errorMessage });
        } catch (e) {
            console.error('Error logging to server:', e);
        }
    }
}